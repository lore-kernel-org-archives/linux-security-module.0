Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598FC7113D
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Aug 2023 09:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358880AbjHRJCX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358911AbjHRJB5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Aug 2023 05:01:57 -0400
X-Greylist: delayed 1506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:01:35 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2E4239
        for <linux-security-module@vger.kernel.org>; Fri, 18 Aug 2023 02:01:35 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id BDC8383B48; Fri, 18 Aug 2023 09:15:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346558; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=RPyn0ITqToG/ygzNyfD+T0yEneOIubcO39o3YhwQMrctMbyK4/BcxtCUss0IibEYw
         ztfZ0LWAWsGchODekJuqMZoscpXYCtsGKDM6WMvU/kjFGF/n056LUhcou2XXNVdE4j
         9dJi1jyqMOPQchSm1sJ7nCDwB6T3BtAKOVlYmaKMnfYDtfRQ2nCSIy5/89GDGHSDms
         6lEt9Waes3qgfRDn0exK2a1RtYyDLkOSO+d84RPx/iu5kwEIrqDx5p/0IVjGp8LLmG
         zy5EygO5dpPuP4Fp7pTetu9D2HOkDxSWgEf1leL7o2nQFwthSPOGzdDXTjjzravf7w
         4uOfWoIxC5cOg==
Received: by mail.leachkin.pl for <linux-security-module@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.ctqi.0.c85hv6ciej@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-security-module@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
