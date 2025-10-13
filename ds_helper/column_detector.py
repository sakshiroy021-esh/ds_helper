import pandas as pd

data = {

    'student_id': [101, 102, 103, 104, 105, 106, 107, 108, 109, 110],

    'test_score': [85.5, 92.0, 78.5, 65.0, 88.0, 95.5, 72.0, 81.0, 99.5, 68.0],

    'grade_level': ['Fresher', 'Top', 'Fresher', 'Junior', 'Top', 'Senior', 'Junior', 'Fresher', 'Senior', 'Top'],

    'zip_code': [90210, 90211, 90210, 90212, 90211, 90210, 90212, 90211, 90210, 90210],

    'feedback_comments': [

        'Excellent work', 'Needs improvement on section 2', 'Good effort',

        'Struggled with the final question', 'Very well written', 'Outstanding performance',

        'Please review the material again', 'Solid understanding of the topic',

        'Perfect score, great job!', 'Average performance, can do better'

    ]

}




df = pd.DataFrame(data)




df

def detect_column_types(dataframe):

    

    unique_value_threshold = 20

    column_types = {}




    for column in dataframe.columns:

        if pd.api.types.is_float_dtype(dataframe[column]):

            column_types[column] = 'Numerical'

            

        elif pd.api.types.is_integer_dtype(dataframe[column]):

           

            if dataframe[column].nunique() < unique_value_threshold:

                column_types[column] = 'Categorical'

            else:

                column_types[column] = 'Numerical' 




        elif pd.api.types.is_object_dtype(dataframe[column]):

             

            if dataframe[column].nunique() < unique_value_threshold:

                column_types[column] = 'Categorical' 

            else:

                column_types[column] = 'Text/Object'




        else:

            column_types[column] = 'Unknown'




    return column_types

detected_types = detect_column_types(df)

print(detected_types)