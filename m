Return-Path: <SRS0=oenN=QJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PHP_ORIG_SCRIPT,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FDC282D7
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Feb 2019 04:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3052086C
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Feb 2019 04:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pbceastgate.org header.i=@pbceastgate.org header.b="NXF6lLWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfBBEdG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:33:06 -0500
Received: from de1.bighostweb.com ([188.40.53.146]:37247 "EHLO
        de1.bighostweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBBEdG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Feb 2019 23:33:06 -0500
X-Greylist: delayed 2050 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 23:33:05 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pbceastgate.org; s=default; h=Sender:Content-Type:MIME-Version:Message-ID:
        From:Date:Subject:To:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7Bs9IE4hnKla3tLeBAzQ/UspoOnQvEkzidOe21f5Yg8=; b=NXF6lLWdgEpPItQ4ZGYDrJcNTi
        wyB5kR8uU00FSzL1x5c2xBx/L9tXUYb3i/4lEyMZ9tDsHZ/whxY/s1fhAxQclnSiE896koTkcgh92
        Ub58KnlL5mD7wVYSzRdyhnfDlzs2jAte6xAlvNl44+IUdH/Xqquy1nEUg5HDN4T0RUH4a6puUF2Sw
        hTRMw48IhFfLtnVu8NiFWfcvWJuzENKT26SMEtcsTMDQ/D6TAEB/HSpFoGq7WtBwzcIwe2Ddq/V1T
        XVQCNwydpQempunwa7E2GQnY5tGqXOwtHxRTnLsTPe+Mzqy0kFvVyDd8aAzLskvt9n+TgYrv8IfQj
        ptk4zUEQ==;
Received: from pbceast by de1.bighostweb.com with local (Exim 4.91)
        (envelope-from <pbceast@de1.bighostweb.com>)
        id 1gpmS5-00C88Q-P5
        for linux-security-module@vger.kernel.org; Sat, 02 Feb 2019 06:58:46 +0300
To:     linux-security-module@vger.kernel.org
Subject: Message
X-PHP-Script: pbceastgate.org/index.php for 185.189.113.38
X-PHP-Originating-Script: 733:class-phpmailer.php
Date:   Sat, 2 Feb 2019 03:58:45 +0000
From:   PBC Eastgate <info@pbceastgate.org>
Message-ID: <a4bd48e3b9eba9b2ae21af43d4dc0cea@pbceastgate.org>
X-Mailer: PHPMailer 5.2.22 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-OutGoing-Spam-Status: No, score=3.3
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - de1.bighostweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [733 501] / [47 12]
X-AntiAbuse: Sender Address Domain - de1.bighostweb.com
X-Get-Message-Sender-Via: de1.bighostweb.com: authenticated_id: pbceast/from_h
X-Authenticated-Sender: de1.bighostweb.com: info@pbceastgate.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello LutherMaf,

Thank you for contacting us. We will get back to you shorty. 

Arise and Shine
PBC Eastgate

-- 
This e-mail was sent from Parklands Baptist Church - Eastgate (http://pbceastgate.org)

