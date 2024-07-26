   Dado('que o usuario consulte as informacoes de funcionario') do
     @get_url = 'http://dummy.restapiexample.com/api/v1/employees'
   end
  
   Quando('ele realizar a pesquisa') do
     @list_employee = HTTParty.get(@get_url)
   end
  
   Entao('uma lista de funcionarios deve retornar') do
     expect(@list_employee.code).to eql 200
     expect(@list_employee.message).to eql 'OK'
   end





  Dado('que o usuario cadastre um novo funcionario') do
    @post_url = ('http://dummy.restapiexample.com/api/v1/create')
  end
  
  Quando('ele enviar as informacoes do usuario') do
    @create_employee = HTTParty.post(@post_url, :headers => {'Content-Type': 'application/json'}, body: {
      "employee_name": "Joaozin",
      "employee_salary": 320800,
      "employee_age": 61,
      "profile_image": ""
    }.to_json)

    puts @create_employee
  end
  
  Entao('esse funcionario sera cadastrado') do
    expect(@create_employee.code).to eql (200)
    expect(@create_employee.msg).to eql  'OK'
    expect(@create_employee["status"]).to eql 'success'
    expect(@create_employee['data']["employee_name"]).to eql 'Joaozin'
    expect(@create_employee['data']["employee_salary"]).to eql (320800)
    expect(@create_employee['data']["employee_age"]).to eql (61)
  end
  