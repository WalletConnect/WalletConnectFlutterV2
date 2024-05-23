import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';

import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_models.dart';

class AuthItem extends StatelessWidget {
  const AuthItem({
    required Key key,
    required this.auth,
    required this.onTap,
  }) : super(key: key);

  final StoredCacao auth;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        color: Colors.green.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              auth.p.domain,
              style: StyleConstants.paragraph,
            ),
            Text(
              auth.p.iss,
            ),
          ],
        ),
      ),
    );
  }
}
