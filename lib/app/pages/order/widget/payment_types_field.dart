import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';

import 'package:vaquinha_burger_provider_bloc/app/core/ui/helpers/size_extensions.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/models/payments_types_model.dart';

class PaymentTypesField extends StatelessWidget {
  final List<PaymentsTypesModel> paymentTypes;
  final ValueChanged<int> valueChanged;
  final bool valid;
  final String valueSelected;

  const PaymentTypesField({
    super.key,
    required this.paymentTypes,
    required this.valueChanged,
    required this.valid,
    required this.valueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forma de Pagamento',
            style: TextStyles.textRegular.copyWith(fontSize: 16),
          ),
          SmartSelect.single(
            title: '',
            selectedValue: valueSelected,
            modalType: S2ModalType.bottomSheet,
            onChange: (selected) {
              valueChanged(int.parse(selected.value));
            },
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: context.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selected.title ?? '',
                            style: TextStyles.textRegular,
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: const Divider(
                        color: Colors.red,
                      ),
                    ),
                    Visibility(
                        visible: !valid,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Selecione uma forma de pagamento',
                            style: TextStyles.textRegular.copyWith(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        )),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom(
              source: paymentTypes
                  .map((e) => {
                        'value': e.id.toString(),
                        'title': e.name,
                      })
                  .toList(),
              title: (index, item) => item['title'] ?? '',
              value: (index, item) => item['value'] ?? '',
              group: (index, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
          )
        ],
      ),
    );
  }
}
