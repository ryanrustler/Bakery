require "sinatra"
require_relative "cakes"
require_relative "muffins"
require_relative "cookies"
require "sendgrid-ruby"







get "/" do

    erb(:main)  
end


get "/cookies" do
    @cookie1 = Cookies.new("Chocolate Cookies","$40.00", "Chocolate chips or chocolate morsels are small chunks of sweetened chocolate, used as an ingredient in a number of desserts, in trail mix and less commonly in some breakfast foods such as pancakes ")
    @cookie2 = Cookies.new("Snickerdoodle Cookies", "$35.00", "The history of this whimsically named treat is widely disputed, but the popularity of this classic cinnamon-sugar-coated cookie is undeniable! ")
    @cookie3 = Cookies.new("Cutout Cookies","$40.00", "TFull of lemony flavor, these cookies are great for any time of year and always popular with family and friends")
    @cookie4 = Cookies.new("Oatmeal Raisin Cookies","$55.00", "The flavor is delicious and they are always well appreciated. This is an all-time favorite with my family.")
    @cookie5 = Cookies.new("Gingersnap Cookies","$55.00", "I discovered this recipe many years ago, and it’s been a favorite among our family and friends since. Who doesn’t like cookies during the holidays?")
    @cookie6 = Cookies.new("Shortbread Cookies","$50.00", "Scottish settlers first came to this area over 150 years ago. My mother herself was Scottish, and—as with most of my favorite recipes—she passed this on to me. I make a triple batch of it each year at Christmas, to enjoy and as gifts.")
erb(:cookies)
end

get "/muffins" do
@muffin1 = Muffins.new("Apple Streusel Muffins","$40.00", "The perfect fall breakfast with hints of nutmeg, cinnamon, and cloves! Best when served warm with a slice of butter. ")
@muffin2 = Muffins.new("S’mores Monkey Bread Muffins", "$35.00", "These muffins are ooey-gooey individual-sized monkey breads made with frozen dinner roll dough, graham cracker crumbs, chocolate chips and mini marshmallows. They couldn't be easier to make, and kids just love them.")
@muffin3 = Muffins.new("Sour Cream Chip Muffins","$40.00", "Take one bite and you’ll see why I think these rich, tender muffins are the best I’ve ever tasted. Mint chocolate chips make them a big hit with my family and friends.")
@muffin4 = Muffins.new("Blueberry Streusel Muffin","$55.00", "What a joy to set out a basket of these moist blueberry muffins with crumb topping on the brunch buffet. People rave when they taste them for the first time.")
@muffin5 = Muffins.new("Cran-Apple Muffins","20.00", "I like to pile a fresh batch of these muffins on a plate when friends drop in for coffee. Even my grandkids enjoy the cranberry and apple flavor combination")
@muffin6 = Muffins.new("Orange Corn Muffins","$50.00", "This is an old recipe that I decided to improve upon—and I like this version so much better! Sometimes, I’ll make lemon corn muffins by substituting lemon peel if I don’t happen to have any oranges on hand. ")

erb(:muffins)

end

get "/cakes" do
@strawberry = Cakes.new("Strawberry","$40.00", "Strawberry cake is a cake that uses strawberry as a primary ingredient. Strawberries may be used in the cake batter, atop cakes and in a strawberry cake's frosting. Some are served chilled or partially frozen, and they are sometimes served as a Valentine's Day dish ")
@chocolate = Cakes.new("Chocolate", "$35.00", "Chocolate cake or chocolate gâteau is a cake flavored with melted chocolate, cocoa powder, or both.. ")
@vanilla = Cakes.new("Vanilla","$40.00", "THIS CLASSIC VANILLA CAKE PAIRS FLUFFY VANILLA CAKE LAYERS WITH A SILKY VANILLA BUTTERCREAM. THE PERFECT CAKE FOR BIRTHDAYS, WEDDINGS, OR ANY OCCASION!")
@red_velvet = Cakes.new("Red velvet","$55.00", "Red velvet cake is traditionally a red, red-brown, mahogany, maroon, crimson or scarlet colored[1] chocolate layer cake, layered with white cream cheese or ermine icing.[2] Common modern red velvet cake is made with red dye;[3][4] the red color was originally due to non-Dutched, anthocyanin-rich cocoa.")
@German_Chocolate = Cakes.new("German Chocolate","$55.00", "German chocolate cake, originally German's chocolate cake, is a layered chocolate cake from the United States filled and topped with a coconut-pecan frosting")
@Carrot_Cake = Cakes.new("Carrot","$50.00", "Carrot cake is a cake that contains carrots mixed into the batter.")

erb(:cakes)
end

get "/home" do
    erb(:contact)
end


post "/contact" do
    @useremail = params[:useremail]
    if(@useremail.length == 0)
        redirect "/"
    else
from = SendGrid::Email.new(email: 'ry-ry123@live.com')
to = SendGrid::Email.new(email: params[:useremail])
subject = 'Sending with SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/html', value:

"
<h1> Cakes </h1>
<ul>
    <li>Strawberry $40.00</li>
    <li>Chocolate $35.00 </li>
    <li> Vanilla $40.00 </li>
    <li> Red velvet $55.00 </li>
    <li> German Chocolate $55.00 </li>
    <li> Carrot $50.00 </li>
</ul>

<h1> Muffins </h1>
<ul>
    <li>Apple Streusel Muffins $40.00</li>
    <li> S’mores Monkey Bread Muffins $35.00</li>
    <li> Sour Cream Chip Muffin $40.00 </li>
    <li> Blueberry Streusel Muffin $55.00 </li>
    <li> Cran-Apple Muffins $55.00 </li>
    <li> Orange Corn Muffins $50.00 </li>
</ul>



<h1> Cookies</h1>
<ul>
    <li>Chocolate Cookies $40.00</li>
    <li> Snickerdoodle Cookies $35.00</li>
    <li> Cutout Cookies $40.00 </li>
    <li> Oatmeal Raisin Cookies $55.00 </li>
    <li> Gingersnap Cookies $55.00 </li>
    <li> Shortbread Cookies $50.00 </li>
</ul>
"
)
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body 
puts response.headers
    end
erb(:contact)
end



