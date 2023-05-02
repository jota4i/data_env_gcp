from datetime import datetime

from airflow import DAG
from airflow.models import Variable
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator


dag_parameters = {
    "owner": "4I_team",
    "start_date": datetime(2023, 2, 3),
    "catchup": False,
}


def set_task_list():
    task_list = ["a", "b", "c", "d"]
    Variable.set("TASK_LIST", task_list, serialize_json=True)


with DAG(
    dag_id="dag_example",
    default_args=dag_parameters,
    description="Dag responsable from get FIPE info and save to datalake",
    tags=["example", "python"],
    schedule=None,
    owner_links={"4I_team": "mailto:j.adelmar@4intelligence.com.br"},
) as dag:
    land_task_list = []
    raw_task_list = []
    trusted_task_list = []

    start_pipeline = EmptyOperator(task_id="start_pipeline")

    set_task_list = PythonOperator(
        task_id=f"set_task_list",
        python_callable=set_task_list,
    )

    end_pipeline = EmptyOperator(task_id="end_pipeline")

    # Orchestration
    start_pipeline >> set_task_list
    set_task_list >> end_pipeline

dag.doc_md = """
# Example

Dag example to create a simple dag

"""
