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
  



  Dado('que o usuario edite as informacoes de um funcionario') do
    @get_employee = HTTParty.get('http://dummy.restapiexample.com/api/v1/employees', :headers => {'Content-Type': 'application/json'})
    puts @get_employee['data'][0]['id']
    @put_url = 'http://dummy.restapiexample.com/api/v1/update/' + @get_employee['data'][0]['id'].to_s
  end
  
  Quando('ele enviar as novas informacoes') do
    @update_employee = HTTParty.put(@put_url, :headers => {'Content-Type': 'application/json'}, body: {
      "employee_name": "Cleber",
      "employee_salary": 3200,
      "employee_age": 22,
      "profile_image": ""
    }.to_json)

    puts @update_employee
  end
  
  Entao('as informacoes serao alteradas') do
    expect(@update_employee.code).to eql (200)
    expect(@update_employee.msg).to eql  'OK'
    expect(@update_employee["status"]).to eql 'success'
    expect(@update_employee['data']["employee_name"]).to eql 'Cleber'
    expect(@update_employee['data']["employee_salary"]).to eql (3200)
    expect(@update_employee['data']["employee_age"]).to eql (22)
  end




Dado('que o usuario queira deletar um funcionario') do
  @get_employee = HTTParty.get('http://dummy.restapiexample.com/api/v1/employees', :headers => {'Content-Type': 'application/json'})
  @delete_url = 'https://dummy.restapiexample.com/api/v1/delete/' + @get_employee['data'][0]['id'].to_s
end

Quando('ele enviar o id') do
  @delete_employee = HTTParty.delete(@delete_url, :headers => {'Content-Type': 'application/json'})
  puts @delete_employee
end

Entao('o funcionario sera deletado') do
  expect(@delete_employee.code).to eql (200)
  expect(@delete_employee.msg).to eql 'OK'
  expect(@delete_employee["status"]).to eql 'success'
  expect(@delete_employee['data']).to eql '1'
  expect(@delete_employee['message']).to eql 'Successfully! Record has been deleted'
end