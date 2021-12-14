<%= simple_form_for [@game, @hand] do |f| %>
      <%= f.submit "Deal card", class: "btn btn-primary" %>
<% end %>
<div>
  <% @game.reservations.each do |reservation| %>
    <div class="player-card m-3">
      <h3 class="text-center"><%= reservation.user.pseudo %></h3>
      <%# <% reservation.user.hand.last.cards %>
      <p class="text-center">
        <% @index1 = 0 %>
        <% @index2 = 1 %>
        <% @game.users.each do |user| %>
          <% user.deck_cards = [] %>
          <% user.deck_cards << @game.hands.last.cards[@index1] %>
          <% user.deck_cards << @game.hands.last.cards[@index2] %>
          <% user.deck_cards.each do |card| %>
            <% if user == current_user && reservation.user == current_user %>
              <%= card.name %>
            <% else %>
              <%= "" %>
            <% end %>
          <% end %>
          <% @index1 += 2 %>
          <% @index2 += 2 %>
        <% end %>
      </p>
    </div>
  <% end %>
</div>
