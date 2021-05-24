defmodule QuizBuilders do
  defmacro __using__(_options) do
    quote do
      alias Mastery.Core.{Quiz, Response, Template}
      import QuizBuilders, only: :functions
    end
  end

  alias Mastery.Core.{Question, Quiz, Template}
end
