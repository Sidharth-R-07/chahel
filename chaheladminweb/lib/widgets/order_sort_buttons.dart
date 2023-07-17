import 'package:flutter/material.dart';

import '../Enums/order_enum.dart';

class OrderSortButtons extends StatefulWidget {
  const OrderSortButtons(
      {super.key, required this.orderSortType, required this.selectOrderType});
  final Function(Orderenum) orderSortType;
  final Orderenum selectOrderType;

  @override
  State<OrderSortButtons> createState() => _OrderSortButtonsState();
}

class _OrderSortButtonsState extends State<OrderSortButtons> {
  Orderenum selectOrderType = Orderenum.all;

  @override
  Widget build(BuildContext context) {
    selectOrderType = widget.selectOrderType;
    setState(() {});
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MaterialButton(
            height: 45,
            onPressed: () {
              selectOrderType = Orderenum.all;
              widget.orderSortType.call(
                Orderenum.all,
              );
              setState(() {});
            },
            color: selectOrderType == Orderenum.all
                ? Colors.blue.shade700
                : Colors.grey.shade200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              "All",
              style: TextStyle(
                color: selectOrderType == Orderenum.all
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MaterialButton(
            height: 45,
            minWidth: 110,
            onPressed: () {
              selectOrderType = Orderenum.pending;
              widget.orderSortType.call(
                Orderenum.pending,
              );
              setState(() {});
            },
            color: selectOrderType == Orderenum.pending
                ? Colors.blue.shade700
                : Colors.grey.shade200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              "Pending",
              style: TextStyle(
                color: selectOrderType == Orderenum.pending
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),

        ///
        ///
        ///
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MaterialButton(
            height: 45,
            minWidth: 110,
            onPressed: () {
              selectOrderType = Orderenum.accepted;
              widget.orderSortType.call(
                Orderenum.accepted,
              );
              setState(() {});
            },
            color: selectOrderType == Orderenum.accepted
                ? Colors.blue.shade700
                : Colors.grey.shade200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              "Accepted",
              style: TextStyle(
                color: selectOrderType == Orderenum.accepted
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),

        ///
        ///
        ///
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MaterialButton(
            height: 45,
            minWidth: 110,
            onPressed: () {
              selectOrderType = Orderenum.packed;
              widget.orderSortType.call(
                Orderenum.packed,
              );
              setState(() {});
            },
            color: selectOrderType == Orderenum.packed
                ? Colors.blue.shade700
                : Colors.grey.shade200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              "Packed",
              style: TextStyle(
                color: selectOrderType == Orderenum.packed
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),

        ////
        ///
        ///

        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MaterialButton(
            height: 45,
            minWidth: 110,
            onPressed: () {
              selectOrderType = Orderenum.shipped;
              widget.orderSortType.call(
                Orderenum.shipped,
              );
              setState(() {});
            },
            color: selectOrderType == Orderenum.shipped
                ? Colors.blue.shade700
                : Colors.grey.shade200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              "Shipped",
              style: TextStyle(
                color: selectOrderType == Orderenum.shipped
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MaterialButton(
            height: 45,
            minWidth: 110,
            onPressed: () {
              selectOrderType = Orderenum.delivered;
              widget.orderSortType.call(
                Orderenum.delivered,
              );
              setState(() {});
            },
            color: selectOrderType == Orderenum.delivered
                ? Colors.blue.shade700
                : Colors.grey.shade200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              "Delivered",
              style: TextStyle(
                color: selectOrderType == Orderenum.delivered
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MaterialButton(
            height: 45,
            minWidth: 110,
            onPressed: () {
              selectOrderType = Orderenum.other;
              widget.orderSortType.call(
                Orderenum.other,
              );
              setState(() {});
            },
            color: selectOrderType == Orderenum.other
                ? Colors.blue.shade700
                : Colors.grey.shade200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              "Other",
              style: TextStyle(
                color: selectOrderType == Orderenum.other
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
