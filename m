Return-Path: <SRS0=ALVC=2P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15745C2D0DB
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Dec 2019 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59C420730
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Dec 2019 08:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLYIdF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Dec 2019 03:33:05 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:15864 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfLYIdF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Dec 2019 03:33:05 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 03:33:03 EST
IronPort-SDR: Pc1hBoKRqziBmeq3P5Fxjfb6P9Q+q1ykDf7F69ICE1cFP1c6KwVktUNnpmJQFznlarwXIW2y10
 Z2HN4an8S2Nw==
IronPort-PHdr: =?us-ascii?q?9a23=3AMA0mehdAFNntY6KN940q7DUylGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS+YB7h7PlgxGXEQZ/co6odzbaP6Oa6AzdLvszJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusUIj4ZuJaQ8xg?=
 =?us-ascii?q?XUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU09nzchM5tg6JBuB+vqRxxw5TKbo+WKfRxcb/Sc9wBSG?=
 =?us-ascii?q?pdXMteSzBNDp+gY4cRCecKIOZWr5P6p1sLtRawAxOjD/71xD9Sh3/22Kw60/?=
 =?us-ascii?q?ggEQHYxgMrAtUDsGjJrNXxKKgSUP26w7PTzTjYavNZwzb96IzSfhA9v/6MWa?=
 =?us-ascii?q?x/cdLLxkYzDQ/FlkmQpJXjMjiI1eoNq3CW4/R9We+tkWIrtg98riS1yssyhY?=
 =?us-ascii?q?TFnIwYx1DC+C5k2og6P8e4R1R+YdO8FZtQsDyVOJVuT8M5RmFopD46yrobuZ?=
 =?us-ascii?q?6nZCQKyIooxxrYa/GfdoiH+BPjVOKLIThmgHJpZL2yiwys8Uin1+LzTMe00F?=
 =?us-ascii?q?FMriVbiNXDqGsN2wTS6siBVPR94l+s1SiS2w3R8O1IPE45mbbBJ5I/zbM8jJ?=
 =?us-ascii?q?QevETbEi/zgkr2jauWdks++uiv7uTqeqnmpoKYN4BoiwHxL74hmtekDOQ9KA?=
 =?us-ascii?q?cOXmyb9f6g1LL9+U32Xq1KgecqnaXDqJDaOdwXprSlDA9NzoYj9xG/Ai+i0N?=
 =?us-ascii?q?QZm3kHMV1EdAucj4f3J17OPer4Dfajg1WsiTtrwvfGMaD8ApXJMHfOi6nhfb?=
 =?us-ascii?q?lj5E5G0gYzzs5Q54hSCr4fJPL/QEjxtMbXDkxxDwvhx+fhFcU4zY4VRHiOHr?=
 =?us-ascii?q?7cNaTerFuFzvwgLvPKZ4IPvjv5bf8/6K3UgGc9iGMaKI2glaMNaXW5AvV4Kg?=
 =?us-ascii?q?3NZXP0mNYEEHsLoAMzV8T4j12FVDdSYzC/QvRvyCs8DdeCBM/7XIGogaCAwi?=
 =?us-ascii?q?7zSoFLYmtHBlmXOXLhdoHCR/oIZTqbKYl5jmpXBvCaV4Y92ET250fBwL19I7?=
 =?us-ascii?q?+M9w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GTKgAeHQNemCMYgtllgkQBGAEBgns?=
 =?us-ascii?q?3GyASk0JUBnUdihKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECEAEBAQEBCAsLBimFSkIBDAGBayKEF4EDgSyDA4JTKa0WGgK?=
 =?us-ascii?q?FI4R1gTYBjBgaeYEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDg?=
 =?us-ascii?q?DglSJEacigjdVgQuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2GTKgAeHQNemCMYgtllgkQBGAEBgns3GyASk0JUBnUdi?=
 =?us-ascii?q?hKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQUBAQEBAQUEAQECE?=
 =?us-ascii?q?AEBAQEBCAsLBimFSkIBDAGBayKEF4EDgSyDA4JTKa0WGgKFI4R1gTYBjBgae?=
 =?us-ascii?q?YEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEacigjdVg?=
 =?us-ascii?q?QuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="298603249"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 25 Dec 2019 09:27:58 +0100
Received: (qmail 32294 invoked from network); 25 Dec 2019 04:33:52 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-security-module@vger.kernel.org>; 25 Dec 2019 04:33:52 -0000
Date:   Wed, 25 Dec 2019 05:33:43 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-security-module@vger.kernel.org
Message-ID: <2080041.259406.1577248423654.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

