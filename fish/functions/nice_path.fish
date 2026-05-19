function nice_path
	set path (string replace -r '.*/dbt-projects/' 'dbt:' $argv[1])
	set path (string replace -r '.*/aws-mwaa-venus/' 'venus:' $path)
	set path (string replace -r '.*/gcp-deployment-manager/' 'gcp-old:' $path)
	set path (string replace -r '.*/gcp-data-hub/' 'gcp-hub:' $path)

	set path (string replace -r '(environment|airflow)/acceptance' 'uat:' $path)
	set path (string replace -r '(environment|airflow)/development' 'dev:' $path)
	set path (string replace -r '(environment|airflow)/production' 'prod:' $path)
	set path (string replace -r '(environment|airflow)/testing' 'tst:' $path)

	echo $path
end
