Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCD3C04AA5
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 09:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiHYJZl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiHYJZc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 05:25:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711DA4BA5E
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 02:25:30 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=GzioCHYAUqDn4TrUj58MxpncXYeVTC9L+GcdZunMMTLaJAE18boRZaYgxifaClSFOo/XnH1GSgqc0ks8h2JoAQcaFMDE1ueLBUtZT3bQwGX1iz+FygmKYFOLtRHS6WGMmo6XWCZezbK7WNr1+iEmJyDrPUlG4SpbCPvezHRZuRlkHu+4m60dJtK/XjHZBCGpDj0XV9fTGaERCpVVXfrHScS3r14ieeCsgFeVsdDItGVvmMh8lGgPvm1U5Iwx+/UyOEsMY/fQVJ4eVrOZgQxnaIG+QXJqo29uHi508gl67WVSgDxbRmBf/1GManGmvSTKpGfuC7esSx/JTyU5SjSv+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5Q7MVkFEcoVNPOO0OpuCgDUER3ee7+GrXmGSHg92rs=;
 b=a/wmH1toQJRAdqEoqLucYeBb37SKdEZMmXR5iPJbgE0JG+aokAoKV8/7w/4fLLgCVBo8SfsMiHjplkFMPe72wPcRP642OGHRN8hF3ml3pdghhoCJmUcwbsCuHMyp8DPk1JPkrpyl6giarvMyULAHowcTEmtBQCHnQCdkDsMTEIJtUXYgmzYFhOsaVlMgMbmac2ZN26vmBLwCFPHoKfg5xo5nYM71uqOQTnoJ/GvvjztfUKFOyll9iLQW0GbRyV3yxNCRtpNHGrZE5uKW1twtzlknydI0vUYrjxn2X/YP1N4iuUD7AtcsqXZ0dmJz9Sws74OFdXtFNUzT/+eCYKsm+A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 4.79.107.243) smtp.rcpttodomain=schaufler-ca.com
 smtp.mailfrom=elektrobit.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=elektrobit.com] dkim=[1,1,header.d=elektrobit.com]
 dmarc=[1,1,header.from=elektrobit.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elektrobit.onmicrosoft.com; s=selector2-elektrobit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Q7MVkFEcoVNPOO0OpuCgDUER3ee7+GrXmGSHg92rs=;
 b=Gmzw58L6Fjf6aWvwJGWaDpbeOgBGcBDRBhpZjSCqAX1KFqpF7beoD0vnhi8Do7wAtdezov5rjhcw840NDlXvkm7i6ipfLY9++x3XRECC2XELnQ690IZ+M1ukVRx3mdKnbrI8lYMhOf0ym5aDEi+eT0rJUMsgYTShxReCOXitEgE=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 SN2PR0801MB2240.namprd08.prod.outlook.com (2603:10b6:804:12::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 09:25:28 +0000
Received: from DM6NAM12FT112.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::14) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Thu, 25 Aug 2022 09:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.onmicrosoft.com;dmarc=fail action=none
 header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 4.79.107.243 as permitted sender)
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 DM6NAM12FT112.mail.protection.outlook.com (10.13.179.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.3 via Frontend Transport; Thu, 25 Aug 2022 09:25:27 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
        Thu, 25 Aug 2022 02:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOyw4QSACKYjnKojDFCg7sf4RbR5NyT0er2ma25G8hV3QMHn+l+pZlS0F5giCMxsMWd0WXnq0lFh/u5ky029QC/ECXkDBmSf5jzpE6Ksi4dbq9jL4VX3fNEbiTfy8cAL/zQu8AHVFvZ7rWgZ1iZxbVSyz5twIVAStls1H8OEtpq/NyKDSZIZ2/HmHIWmvJSEJht7AOsCjeLoWsXbj5Kxk5vh8yumpWqVg24FNN5+/C1U6Aejin5w36ApMDg1LxV3oY+4E+bzQ+2XJbLTN50wXJXJWCdRK1ilfKA3Ae+/7ixPbLntBuyBmxjuEPJoG0x/EfzA0uN6bPufCRo36PNDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5Q7MVkFEcoVNPOO0OpuCgDUER3ee7+GrXmGSHg92rs=;
 b=eXhihuwYehL45+rHgksCtN2Fxjk1o1reTXcXxffGFkJbH3O/Fu1/QVpvt3yi4FHMWeUgS3b+2zsdHjm/KPNbsFtKjkyb6x+0Xr6DR6PZErgm+hSAOttKrpZeM1w83PNgIjg7lGgnd1PGifIiPd+1589wVa2c5b8phfZ6kprVyyOvfNL1mEQRWwy91YZ5WaiUsvbA90gGKixVgKq8uo6Ugsrl8dY3bBgIbN74t8GSqH3DIyGzkvM7aJ+L2mOoZQ8v6IxSWiYL1ptT50mpzuzsYwshH4w48VexVSzd7SHe2lHNBbG0YPn+eC5Tiziw8pkwa56b/D9qvOHCOeAdZ9kAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elektrobit.com; dmarc=pass action=none
 header.from=elektrobit.com; dkim=pass header.d=elektrobit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elektrobit.onmicrosoft.com; s=selector2-elektrobit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Q7MVkFEcoVNPOO0OpuCgDUER3ee7+GrXmGSHg92rs=;
 b=Gmzw58L6Fjf6aWvwJGWaDpbeOgBGcBDRBhpZjSCqAX1KFqpF7beoD0vnhi8Do7wAtdezov5rjhcw840NDlXvkm7i6ipfLY9++x3XRECC2XELnQ690IZ+M1ukVRx3mdKnbrI8lYMhOf0ym5aDEi+eT0rJUMsgYTShxReCOXitEgE=
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a4::7) by
 VI1P195MB0783.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:153::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Thu, 25 Aug 2022 09:25:24 +0000
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f]) by DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f%7]) with mapi id 15.20.5546.022; Thu, 25 Aug 2022
 09:25:24 +0000
From:   "Lontke, Michael" <Michael.Lontke@elektrobit.com>
To:     "casey@schaufler-ca.com" <casey@schaufler-ca.com>
CC:     "Ostertag, Martin" <Martin.Ostertag@elektrobit.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        =?utf-8?B?V2Vpw58sIFNpbW9uZQ==?= <Simone.Weiss@elektrobit.com>,
        "Valleru, Yuvarajesh" <Yuvarajesh.Valleru@elektrobit.com>,
        "Irgang, Thomas" <Thomas.Irgang@elektrobit.com>
Subject: SMACK LSM checks wrong object label during ingress network traffic
Thread-Topic: SMACK LSM checks wrong object label during ingress network
 traffic
Thread-Index: AQHYuGSajWIvX43eyUywpT/36FKxzQ==
Date:   Thu, 25 Aug 2022 09:25:24 +0000
Message-ID: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elektrobit.com;
X-MS-Office365-Filtering-Correlation-Id: bc641d8a-239b-4fad-17b2-08da867bbfc3
x-ms-traffictypediagnostic: VI1P195MB0783:EE_|DM6NAM12FT112:EE_|SN2PR0801MB2240:EE_
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KqlQkUJSBg6Sg+HVgtgZswBurSwzfRstzLNW07wVLms0gaxN95vBnhkhjMZeBQQ2RJcG3NobJb7aH+k9Nabh/vjG2g9tY60hjUbN2e4R0o4KrF4DawYMg+Dgd8KjLN/19wMoZtp43a3PBGwEoe7Y5BiH/WDLMsI5/BRJc59idr9MIQ4P6qHTq5BTGjNIs1lQQ7Ak+F4dR8WCe6uk724ltkdU7zVd39lJHwImf1r0DeOTq2hpugkdVh9yNy7GWQqJumUsIc0VMcXsbke+ypVuaUzPl9E1YQboOWqRJ0rcUtmzLRpho83cX80Cpcjsg4fzWdaSHuIGHGboJ5+8M5ecLQyrG1g2sijzWpdKRKQWHwfShCdXXAovQrm03fkm/1BLphM1WvBbGGEf1BqzT19Dl4Go38S5vW10ZHpFHeJuSnejNT7bRDbFn/l8CNlAh2R6qjF9Bkv5Ih/jXSpdfnNLpYEkyA9ywmOI2i1DMNGxehI9eiTzy1cm858k5MeoCnx84meeFTRHue20H2LHl6WRAWyAhycG1vzwx7qeIE0UAR+ISR1ss0NV4fbY2e90qpSATo2iVWlUFq4levoc3aX8Y74kLLdSlKRznVeSJa7WRg89PDcg80h6Bo0dzgMXlMkbLHOYDhx4jx7x9FzK3/reNvLpTYPSUlL6gYcocI2KXRP6OYYUgnsKJFp9Mxcvnsk7Mc0PttcWZ+qbkPfwzz4k5S1SwTSuuIGLZWjFir7/8526ao3UvfN+kDMH7Us8bVruYnJ2fD+hpIk5DhkNFrFZXg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P195MB1628.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(346002)(136003)(376002)(366004)(122000001)(38070700005)(86362001)(38100700002)(91956017)(76116006)(54906003)(316002)(6916009)(66946007)(2906002)(8936002)(5660300002)(64756008)(66446008)(66556008)(83380400001)(8676002)(4326008)(66476007)(2616005)(186003)(478600001)(41300700001)(6486002)(71200400001)(6506007)(6512007)(107886003)(36756003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA66833A0B3B9448AD402E96443BB7CA@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0783
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DM6NAM12FT112.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 765272aa-ee92-4f4e-8dfd-08da867bbd72
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ddOjngkMlGlUFCYQNlwZ3BDcyzR8IIjNBpJUUXIduZvfoXgJDhvVJ4RhtUq4zKd90H7y52r2/7GYFDYBWRmJH09cQdwnfoD87wmNBP8jeKwfqvamT7gUdePn1qOc6wn5f1KCwOsVDMkcEsHKF2soVc0HeOwHNw2HoHFeWvi87mYs6RUqRY4wJwKHGEFfpDAMXx0l8o/P8y4qATcgYPHv96r+HE2t/oQbk1edxRIXeUaPZ03FPg9b1Sfli+wcpHgdYXF0rGNoKwYA34KJto7W0wjnvM4TfNSpJaNRgRHAQ51paSpKwDCglrz492Ayr2SPQpPPsIFdFlxQKL0RiuHwnOrhvnGynaT7QRkk5QMLTNSeGvaa5kIo6BgY03aJEq8kRgL7iVC4lamr+oAk3BJAxQR1YLmZImv8y7fc7vnxSuTkl7PR/gtycbJJiOFGUokKO5s+4ab0q103T/S5rX9NVVEPHCFcN3tbnjB7Abq8gDmJg3dGR9PTYMYQsZW/T3N52RVOz1/WWk0+GKu14HYYtpJK4UbvxTeyhBsQylIqd8wuU18GaSwd6/MCsFGBqspGoZ4e0+ge0CwggbZO2wYoPwLiRY/6+h50fBilZAOtxqT79iC5P1nif+Ryd4f+O4xSXu7rSsbbSqZ4uWxHdn3dx/Wp5rWpNZJXg7+OmbT6fNdx/p+EqM5yb/IuWAmPqIjXHRZTdNrhTo14lEv1toMpCkmrewZDMFJvjodo+D1+WZO5K5q3t0ES3hTEbVyEDQtfZCCEofpiYxAHFMJobBU2H3WErSg8UFP/nt56/swWiEQo0zPRg8eLdPh5N+FfbE2
X-Forefront-Antispam-Report: CIP:4.79.107.243;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(6486002)(6512007)(478600001)(5660300002)(82310400005)(41300700001)(316002)(70206006)(4326008)(8676002)(6916009)(54906003)(36756003)(8936002)(107886003)(70586007)(40480700001)(2616005)(336012)(47076005)(186003)(83380400001)(26005)(2906002)(6506007)(36860700001)(86362001)(82740400003)(81166007)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 09:25:27.8773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc641d8a-239b-4fad-17b2-08da867bbfc3
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT112.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB2240
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

SGVsbG8gTXIuIFNjaGF1ZmxlciwNCg0Kd2Ugb2JzZXJ2ZWQgdGhlIGZvbGxvd2luZyBiZWhhdmlv
ciBvZiB0aGUgU01BQ0sgTFNNIGtlcm5lbCBmZWF0dXJlLg0KDQpQUk9CTEVNOiBTTUFDSyBMU00g
aXMgY2hlY2tpbmcgdGhlIHdyb25nIGxhYmVsIHdoZW4gcmVjZWl2aW5nIG5ldHdvcmsNCnBhY2tl
dHMgZHVyaW5nIGhpZ2ggc3lzdGVtIGxvYWQuDQoNCkZ1bGwgRGVzY3JwaXRpb24gb2YgdGhlIFBy
b2JsZW06IER1cmluZyBhIHRlc3Qgc2NlbmFyaW8gaW52b2x2aW5nIGhpZ2gNCnN5c3RlbSBsb2Fk
IChjcHUsIG1lbW9yeSBhbmQgaW8pIGluIGNvbWJpbmF0aW9uIHdpdGggaW5ncmVzcyB0Y3ANCm5l
dHdvcmsgdHJhZmZpYywgU01BQ0sgaXMgY2hlY2tpbmcgd3Jvbmcgb2JqZWN0IGxhYmVscyBsZWFk
aW5nIHRvDQpkZW5pZWQgYWNjZXNzIGZvciB2YWxpZCBzY2VuYXJpb3MuDQpJbiBiZWxvdyB0ZXN0
IHNjZW5hcmlvIHRoZSBsYWJlbCAnc3RyZXNzdGVzdCcgaXMgb25seSB1c2VkIGZvciB0aGUNCmFw
cGxpY2F0aW9uICdzdHJlc3MnIGJ1dCBhcHBlYXJzIGluIFNNQUNLIGF1ZGl0IGxvZ3MgYXMgb2Jq
ZWN0IHRvZ2V0aGVyDQp3aXRoIG5ldGxhYmVscy4NCg0KVGhpcyBpc3N1ZSBpbml0aWFsbHkgYXBw
ZWFyZWQgb24gaGFyZHdhcmUgd2l0aCBrZXJuZWwgdmVyc2lvbiA0LjE0LjIzNw0KYnV0IHdhcyBh
bHNvIGJlaW5nIHJlcHJvZHVjZWQgd2l0aCBxZW11IGZvciBrZXJuZWwgdmVyc2lvbiA0LjE0LjI5
MCBhbmQNCmxhdGVzdCA2LjAtcmMyLiBUaGUgdXNlZCByb290ZnMgd2FzIGdlbmVyYXRlZCB2aWEg
YnVpbGRyb290IHZlcnNpb24NCjIwMjIuMDgtcmMxLg0KDQoNCktFWVdPUkRTOiBzbWFjaywgbmV0
d29ya2luZw0KDQpLRVJORUwgSU5GT1JNQVRJT046IExpbnV4IHN0YWJsZSBrZXJuZWwNCg0KS0VS
TkVMIFZFUlNJT046IDQuMTQuMjM3LCA0LjE0LjI5MCwgNi4wLXJjMg0KDQoNCktFUk5FTCBDT05G
SUc6IHNtYWNrIHJlbGF0ZWQga2VybmVsIGNvbmZpZ3VyYXRpb24NCg0KQ09ORklHX05FVExBQkVM
PXkNCg0KQ09ORklHX1NFQ1VSSVRZX05FVFdPUks9eQ0KDQpDT05GSUdfU0VDVVJJVFlfU01BQ0s9
eQ0KDQpDT05GSUdfREVGQVVMVF9TRUNVUklUWV9TTUFDSz15DQoNCkNPTkZJR19ERUZBVUxUX1NF
Q1VSSVRZPSJzbWFjayINCg0KQ09ORklHX0NSQ19DQ0lUVD15DQoNCkNPTkZJR19FWFQ0X0ZTX1NF
Q1VSSVRZPXkNCg0KQ09ORklHX1RNUEZTX1hBVFRSPXkNCg0KQ09ORklHX1NRVUFTSEZTX1hBVFRS
PXkNCg0KDQpTdGVwcyB0byByZXByb2R1Y2UgdGhlIGlzc3VlOg0KT24gcWVtdToNCiogU2V0dXAg
cWVtdSB3aXRoIG5ldHdvcmsgY29ubmVjdGlvbiB0byB0aGUgaG9zdCB2aWEgdGFwIGRldmljZS4N
CiogQWRkIGlwNmhvc3QgbGFiZWwgdmlhIHNtYWNrZnM6DQoNCmVjaG8gIjxob3N0LWlwdjYtYWRk
cj4gbmV0X2hvc3QiID4gL3N5cy9mcy9zbWFja2ZzL2lwdjZob3N0DQoNCiogQWRkIHJ1bGUgZm9y
IGFsbG93ZWQgbmV0d29yayB0cmFmZmljOg0KDQplY2hvICJ0Y3BfdGVzdCBuZXRfaG9zdCB3IiA+
IC9zeXMvZnMvc21hY2tmcy9sb2FkMg0KDQoqIFRoZSBmb2xsb3dpbmcgc2NyaXB0IHdhcyB1c2Vk
IGZvciBsaXN0ZW5pbmcgZm9yIHBhY2tldHMgb24gcWVtdToNCg0KY2F0IDw8IEVPRiA+IHRjcF9s
aXN0ZW4uc2gNCiMhL2Jpbi9zaA0Kd2hpbGUgdHJ1ZTsNCmRvDQogICAgc29jYXQgLSBUQ1A2LUxJ
U1RFTjpcJDEscmV1c2VhZGRyLGZvcmsgPiAvZGV2L251bGwgJiBwcz1cJCENCiAgICBzbGVlcCAx
DQogICAga2lsbCAtOSBcJHBzDQpkb25lDQpFT0YNCg0KKiBTdGFydCB0aGUgc2NyaXB0IHR3aWNl
LCBvbmUgYWxsb3dpbmcsIG9uZSBkZW55aW5nIHRyYWZmaWMgdmlhIFNNQUNLOg0KDQplY2hvIHRj
cF90ZXN0ID4gL3Byb2Mvc2VsZi9hdHRyL2N1cnJlbnQgJiYgc2ggdGNwX2xpc3Rlbi5zaCAxMjM0
NSAyPiYxDQovZGV2L251bGwgJg0KZWNobyB0Y3BfdGVzdDIgPiAvcHJvYy9zZWxmL2F0dHIvY3Vy
cmVudCAmJiBzaCB0Y3BfbGlzdGVuLnNoIDEyMzQ2IDI+JjENCi9kZXYvbnVsbCAmDQoNCiogU3Rh
cnQgJ3N0cmVzcycgdG8gZ2VuZXJhdGUgc3lzdGVtIGxvYWQgd2l0aCAnc3RyZXNzdGVzdCcgYXMg
U01BQ0sNCmxhYmVsOg0KDQplY2hvIHN0cmVzc3Rlc3QgPiAvcHJvYy9zZWxmL2F0dHIvY3VycmVu
dCAmJiBzdHJlc3MgLWMgMiAtaSA0IC1tIDIgLS0NCnZtLWJ5dGVzIDY0TSAmDQoNCg0KT24gaG9z
dDoNCiogR2VuZXJhdGUgcmFuZG9tIGRhdGEgdG8gc2VuZCB2aWEgbmV0d29yazoNCiANCmRkIGlm
PS9kZXYvdXJhbmRvbSBvZj10ZXN0L2RhdGEgYnM9MU0gY291bnQ9MTANCg0KKiBVc2UgdGhlIGZv
bGxvd2luZyBzY3JpcHQgdG8gY29udGlub3VzbHkgc2VuZCBwYWNrZXRzOg0KDQpjYXQgPDwgRU9G
ID4gcGFja2V0X3RjcC5zaA0KIyEvYmluL3NoDQp3aGlsZSB0cnVlOw0KZG8NCiAgICBjYXQgZGF0
YSB8IG5jIDxxZW11LWlwdjYtYWRkcj4gXCQxDQpkb25lDQpFT0YNCg0KKiBFeGVjdXRlIHRoZSBz
Y3JpcHQgdHdpY2UgdG8gYWRkcmVzcyBib3RoIHJlY2VpdmluZyBhcHBsaWNhdGlvbnMgb24NCnFl
bXU6DQoNCmJhc2ggcGFja2V0X3RjcC5zaCAxMjM0NSAyPiYxID4gL2Rldi9udWxsICYNCmJhc2gg
cGFja2V0X3RjcC5zaCAxMjM0NiAyPiYxID4gL2Rldi9udWxsICYNCg0KDQpPYnNlcnZpbmcgdGhl
IHByb2JsZW06DQoNCkFmdGVyIGxldHRpbmcgdGhpcyBydW4gZm9yIH41LTEwIG1pbnMgb25seSBh
dWRpdCBtZXNzYWdlcyByZWdhcmRpbmcgdGhlDQpsYWJlbCAndGNwX3Rlc3QyJyBhcmUgZXhwZWN0
ZWQuDQpUaGUgaXNzdWVzIGNhbiBiZSBzZWVuLCB0aGF0IGFsc28gb3RoZXIgbGFiZWxzIGFyZSBy
YW5kb21seSBhcHBlYXJpbmcNCmluIHRoZSBsb2dzIChtb3N0IGNvbW1vbmx5IGhlcmUgJ3N0cmVz
c3Rlc3QnLCBwcm9iYWJseSBzaW5jZSBpdA0Kb2NjdXBpZXMgbW9zdCBvZiB0aGUgY3B1IHRpbWUp
Og0KDQpqb3VybmFsY3RsIHwgZ3JlcCBhY3Rpb249ZGVuaWVkIHwgZ3JlcCAtdiB0Y3BfdGVzdDIN
Cg0KDQpFeGFtcGxlIGVudHJ5IHdpdGgga2VybmVsIDYuMC1yYzI6DQpBdWcgMjQgMTI6Mzg6MzIg
YnVpbGRyb290IGF1ZGl0WzYwOV06IEFWQyBsc209U01BQ0sgZm49c21rX2lwdjZfY2hlY2sNCmFj
dGlvbj1kZW5pZWQgc3ViamVjdD0ibmV0X2hvc3QiIG9iamVjdD0ic3RyZXNzdGVzdCIgcmVxdWVz
dGVkPXcNCnBpZD02MDkgY29tbT0ic3RyZXNzIiBzYWRkcj08aG9zdC1pcHY2LWFkZHI+IGRlc3Q9
NTA3MTQNCg0KDQpJZiB5b3UgYXJlIG1pc3NpbmcgYWRkaXRpb25hbCBpbmZvIHBsZWFzZSByZWFj
aCBvdXQgdG8gbWUuDQpUaGFuayB5b3UgaW4gYWR2YW5jZSBhbmQgYmVzdCByZWdhcmRzLA0KDQpN
aWNoYWVsIExvbnRrZQ0K
