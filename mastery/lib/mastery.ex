defmodule Mastery do
  alias Mastery.Boundary.{QuizManager, QuizSession, QuizValidator, TemplateValidator}
  alias Mastery.Core.Quiz

  def build_quiz(fields) do
    with :ok <- QuizValidator.errors(fields),
         :ok <- GenServer.call(QuizManager, {:build_quiz, fields}),
         do: :ok,
         else: (error -> error)
  end

  def add_template(title, fields) do
    with :ok <- TemplateValidator.errors(fields),
         :ok <- GenServer.call(QuizManager, {:add_template, title, fields}),
         do: :ok,
         else: (error -> error)
  end

  def take_quiz(title, email) do
    with %Quiz{} = quiz <- QuizManager.lookup_quiz_by_title(title),
         {:ok, _} <- QuizSession.take_quiz(quiz, email),
         do: {title, email},
         else: (error -> error)
  end

  def select_question(name) do
    QuizSession.select_question(name)
  end

  def answer_question(name, answer) do
    QuizSession.answer_question(name, answer)
  end
end
