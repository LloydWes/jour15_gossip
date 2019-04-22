require 'sinatra'

get '/hello' do
  '<hi>Hello World !</h1>
  <form action="/hello" method="post">
  <input type="submit" value="test">
  </form>'
end

post '/hello' do
  '<h1>Vous avez complété un formulaire</h1>'
end


    # La page d'accueil du site affichera tous les potins que nous avons en base.
    # Cette page d'accueil donnera un lien pour un formulaire où quiconque pourra ajouter un potin en base.
    # Chaque potin aura une page dédiée.
