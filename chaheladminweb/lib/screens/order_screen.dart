import 'dart:developer';

import 'package:ecommerceadminweb/Enums/order_enum.dart';
import 'package:ecommerceadminweb/widgets/order_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../provider/order_provider.dart';
import '../widgets/order_sort_buttons.dart';
import 'order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController searchController = TextEditingController();
  Orderenum selectOrderStatus = Orderenum.all;
  ScrollController scrollController = ScrollController();
  bool isOrderSortshutter = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false)
          .getFirebaseData(null, selectOrderStatus, null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            title: const Text(
              "All orders",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 5),
                  height: isOrderSortshutter ? null : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  //remove search data and get order data
                                  Provider.of<OrderProvider>(context,
                                          listen: false)
                                      .getFirebaseData(
                                          null, selectOrderStatus, null);
                                }
                              },
                              onSubmitted: (value) {
                                Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .getFirebaseData(
                                        null, selectOrderStatus, value);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                prefixIcon: const Icon(
                                  IconlyLight.search,
                                  color: Colors.black,
                                  size: 17,
                                ),
                                isDense: true,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if (searchController.text.isNotEmpty) {
                                        searchController.clear();
                                        Provider.of<OrderProvider>(context,
                                                listen: false)
                                            .getFirebaseData(
                                                null, selectOrderStatus, null);
                                      }
                                    },
                                    icon: const Icon(Icons.close)),
                                hintText: "Order ID, Phone...",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                                contentPadding: const EdgeInsets.all(10),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: OrderSortButtons(
                          selectOrderType: searchController.text.isEmpty
                              ? selectOrderStatus
                              : Orderenum.all,
                          orderSortType: (value) {
                            selectOrderStatus = value;
                            Provider.of<OrderProvider>(context, listen: false)
                                .getFirebaseData(null, selectOrderStatus, null);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (isOrderSortshutter) {
                    isOrderSortshutter = false;
                  } else {
                    isOrderSortshutter = true;
                  }
                  setState(() {});
                },
                child: Icon(isOrderSortshutter
                    ? Icons.arrow_drop_up_outlined
                    : Icons.arrow_drop_down),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 20, right: 20, top: isOrderSortshutter ? 20 : 0),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "OrderID",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Text(
                          "Date",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Text(
                          "Customer",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 250,
                        ),
                        Text(
                          "items",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Text(
                          "Payment",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Text(
                          "Status",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Text(
                          "Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: (Provider.of<OrderProvider>(context)
                              .isFirebaseDataLoding ==
                          false)
                      ? Provider.of<OrderProvider>(context).orderList.isNotEmpty
                          ? SizedBox(
                              width: 1335,
                              child: CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      childCount:
                                          Provider.of<OrderProvider>(context)
                                              .orderList
                                              .length,
                                      (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            bool isChangeOrderStatus =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return OrderetailScreen(
                                                    orderDetails: Provider.of<
                                                                OrderProvider>(
                                                            context)
                                                        .orderList[index],
                                                  );
                                                },
                                              ),
                                            );
                                           
                                            if (isChangeOrderStatus) {
                                           
                                              // ignore: use_build_context_synchronously
                                              Provider.of<OrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .getFirebaseData(null,
                                                      selectOrderStatus, null);
                                                      
                                            }
                                          },
                                          child: OrderFrame(
                                              orderDetails:
                                                  Provider.of<OrderProvider>(
                                                          context)
                                                      .orderList[index]),
                                        );
                                      },
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                      child: Container(
                                    width: 1335,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Provider.of<OrderProvider>(context)
                                                        .isFirebaseDataLoding ==
                                                    false &&
                                                searchController.text.isEmpty
                                            ? Provider.of<OrderProvider>(
                                                            context)
                                                        .circularProgressLOading ==
                                                    true
                                                ? Tooltip(
                                                    message:
                                                        "Get the next list",
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10),
                                                      height: 45,
                                                      width: 45,
                                                      padding: EdgeInsets.zero,
                                                      child: MaterialButton(
                                                        elevation: 3,
                                                        color: Colors.white,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        200))),
                                                        onPressed: () {
                                                          if (Provider.of<OrderProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isNextListDataLoding ==
                                                              false) {
                                                            Provider.of<OrderProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getFirebaseData(
                                                                    Provider.of<OrderProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .orderList
                                                                        .last
                                                                        .lastdoc,
                                                                    selectOrderStatus,
                                                                    null);
                                                          }
                                                        },
                                                        child: Provider.of<OrderProvider>(
                                                                        context)
                                                                    .isNextListDataLoding ==
                                                                false
                                                            ? const Icon(
                                                                CupertinoIcons
                                                                    .add,
                                                                color: Colors
                                                                    .black,
                                                                size: 22,
                                                              )
                                                            : const CupertinoActivityIndicator(),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 45,
                                                    color: Colors.white,
                                                  )
                                            : Container(
                                                height: 45,
                                                color: Colors.white,
                                              ),
                                      ],
                                    ),
                                  )),
                                  const SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: 30,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 300,
                                  width: 1335,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/empty.png",
                                        height: 70,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 300,
                              width: 1335,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoadingAnimationWidget.waveDots(
                                    color: Colors.grey, //.shade600,
                                    size: 70,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
