Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B15CD5491
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Sep 2023 07:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjISHoG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjISHoF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Sep 2023 03:44:05 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:44:00 PDT
Received: from mail.leeswilly.pl (mail.leeswilly.pl [89.116.26.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3937C100
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 00:43:59 -0700 (PDT)
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
        id 61C2076133D; Tue, 19 Sep 2023 09:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
        t=1695108928; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
        h=Date:From:To:Subject:From;
        b=xLIvBHuSOB+bkv7RnNrlVKbgzp+rkG4NvV76FusP8ShVhYUh9Sy0t5pgoeoa/b7Sy
         rGjjwQEFX6rBX51H2VgjqzHb5A6DxrHKqY8ZLRHfYb14VqQfhKoy0wSefh703tiPYK
         fg752uugJF6tmcKdu93oi0aexTuPAPtZ9vlw94yf5kEh/hPkdU3LZXg4gfOYvMEQRb
         EWNzkrRzhMXRVdLVZOHxxvBXciKKw8N0yc5S6L3dxvlZJ2yJKAWEpZ3/Dxn+tbiGi+
         XEh0pwbr/kDvqNfkk1P+8PgXH/MkCWVmIWVK2I113FgO4lrVBEHnsw5u4SFqJBc/Nv
         /G/8zfvIhRY5g==
Received: by mail.leeswilly.pl for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 07:35:17 GMT
Message-ID: <20230919084500-0.1.3z.bcov.0.1npond561b@leeswilly.pl>
Date:   Tue, 19 Sep 2023 07:35:17 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To:     <linux-security-module@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Jakub Lemczak
