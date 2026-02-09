import 'package:flutter/material.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/card_model.dart';
import 'package:kick26/src/presentation/market/widgets/search_field_widget.dart';

class MarketSearchScreen extends StatefulWidget {
  const MarketSearchScreen({super.key, required this.cards});

  final List<CardModel> cards;

  @override
  State<MarketSearchScreen> createState() => _MarketSearchScreenState();
}

class _MarketSearchScreenState extends State<MarketSearchScreen> {
  final FocusNode _searchFocus = FocusNode();
  List<CardModel> _filteredCards = [];

  @override
  void initState() {
    super.initState();
    _filteredCards = widget.cards;
    Future.delayed(Duration(milliseconds: 100), () {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 72,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ConstColors.baseColorDark5)),
            child: Center(child: GoldGradient(child: const Icon(Icons.chevron_left, size: 28))),
          ),
        ),
        title: _buildSearchField(),
        centerTitle: true,
      ),
      body:
          _filteredCards.isEmpty
              ? Center(
                child: GoldGradient(
                  child: Text(
                    "Sorry, We Can't find what you looking for",
                    style: TextStyle(fontFamily: poppinsSemiBold),
                  ),
                ),
              )
              : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _filteredCards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.82,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final card = _filteredCards[index];
                  return SizedBox(
                    height: 180,
                    child: FlipPlayerCardWidget(card: card, cards: widget.cards, tag: "market_search_screen"),
                  );
                },
              ),
    );
  }

  Widget _buildSearchField() {
    return SearchFieldWidget(
      focusNode: _searchFocus,
      onChanged: (value) {
        final query = value.toLowerCase();

        final results =
            widget.cards.where((card) {
              return (card.player.name?.toLowerCase().contains(query) ?? false) ||
                  (card.club.name?.toLowerCase().contains(query) ?? false);
            }).toList();

        setState(() {
          _filteredCards = results;
        });
      },
    );
  }
}
