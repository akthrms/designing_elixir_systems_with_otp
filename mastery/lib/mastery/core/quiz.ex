defmodule Mastery.Core.Quiz do
  alias Mastery.Core.{Question, Response, Template}

  defstruct title: nil,
            mastery: 3,
            templates: %{},
            used: [],
            current_question: nil,
            last_response: nil,
            record: %{},
            mastered: []

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def add_template(%__MODULE__{} = quiz, fields) do
    template = Template.new(fields)

    templates =
      update_in(
        quiz.templates,
        [template.category],
        &add_to_list_or_nil(&1, template)
      )

    %{quiz | templates: templates}
  end

  defp add_to_list_or_nil(nil, %Template{} = template), do: [template]
  defp add_to_list_or_nil(templates, %Template{} = template), do: [template | templates]
end
