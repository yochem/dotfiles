function dbt
    if command -sq dbt
        command dbt $argv
    else
        uv run dbt $argv
    end
end
