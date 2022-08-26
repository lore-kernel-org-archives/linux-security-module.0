Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E9ECAAD2
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Aug 2022 08:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiHZIl3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbiHZIkr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Aug 2022 04:40:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC4C7415
        for <linux-security-module@vger.kernel.org>; Fri, 26 Aug 2022 01:40:32 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=fBhWBvH7hEj96X4A49iAFWptP6q09jSi2nw7pi7cJUfuugDYcKkFjM+Q7xeUqS1K0BWcHL4Dd+gThsO5GzhNibrbm6Z02cYAhvBQvNEaXEukLQ85TTHv3Ublt+bgWvWEbPpawhyueIPEIAi3Sh6bMfpE4f6qFMMnt6kLU/SiQyyVRghDQmMJfBQqA0sENae73mgrO9G95abCvjiYH2sxPkZevkaR0DDwTkMzO0YK/Rk0M5nPBgMfQkugxFP7VyH8oGfubyGHv0EpoWBHhkQd+/iGMV0IwgyGi6222c0guDMBhCVYR+FBL7BXE6jCxIve9QT8UjRves5C8P5fmf2hMw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVx2wZczlYGUjjMQ+jyhDN5BpBfxZ1WOUMQcnDTxJ9M=;
 b=ggbn22eknpma1cD0tAeRjwwqRx2nh50ocVtYLkKVZ4g437BHTFCqBgBiMnbrskEJO1P9FhgCilYiVvE/J5r1VeK1R+PUy4DPi1dVaS0aXGWz2CixN4G6NSkhM8GlGI3rEcLtgOXOWKsdVs4Lui8+w/4kI6F7kQ8y4fzEn3NwyUksxYMHqSlHVFiQJBfAX08KzOF16C1Ls714gAgMS/1JpCeczrIY1ZH7aI5qbWFHcxJ0ICAorx5DlhPGIVSi6kqZecrr1C4YD6XY/eJzPVuIYDcrtvVU3ljPZ9RsKyygRVhw0glAbjsOKu0IpdfuXweYwaosHy0ZwrpmHKV/CN8K0g==
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
 bh=sVx2wZczlYGUjjMQ+jyhDN5BpBfxZ1WOUMQcnDTxJ9M=;
 b=cPAAf79ahXzkvZAJsbWJOQd/ma8Q1+H1QKy9VMXHXiGyJPbkLY0nfkKqRZuOX6YHew5JXh9x+zi2YwSFGpg6AvatDzJeNfbvz6XyyZkjcy2eMbfVxUX1UjFsDtLdnRIVwl9+hqn25txdabBNMtcsNcCMvLffaqADbg+5nlnxf9s=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by BN6PR08MB2500.namprd08.prod.outlook.com (2603:10b6:404:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 08:40:30 +0000
Received: from MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::12) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 08:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.onmicrosoft.com;dmarc=fail action=none
 header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 4.79.107.243 as permitted sender)
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 MW2NAM12FT038.mail.protection.outlook.com (10.13.180.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.3 via Frontend Transport; Fri, 26 Aug 2022 08:40:29 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
        Fri, 26 Aug 2022 01:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV6Kk/WEVQPsaRl9Mo5gvXceVvcK3Fg9oel282D4oQJlIif3EskEDtPCI23GwLAKBiIS26zFaUpbnXD4yh8XvZKEjNbq8ZShRKXv4Gvtcv7ZLLmW5Xi4ssGYOZUCt1adVjvpBsO7Y4h2y9W89ZFZLgLaO18s50JsmURnLAoOU+jvByyN/lsfL+OmbnVtJrXMHPiId9ucCeBonhQhrLWT66Kglja8bOhHKiHYv+XoNqsxYI+rJHap4UR9SIOsae8SkJnVFZLV4DKjpNgJysyuyn2kKCfNGM+cqOi0Rix9al55c1N1MUeay/qIUsD0pN9NSt/XcG85gYMgX671cqBnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVx2wZczlYGUjjMQ+jyhDN5BpBfxZ1WOUMQcnDTxJ9M=;
 b=cpwsO4JAoRqu7Hi7kT7SC7yFSqhkf2GefBxyJNswr1bCzD7PS9zhsyyVdq5PLxum7yqdPGs/alOfTKkU8LDWxOsqxaVh6E0bjyHXFK6uSDVUb9KG0MXMOqmEnYOzgYU6M+knaNyS5Cj/vMNSSqGl4pDRbG4ILGRIPFaGxg6DmVi9MfZupbcr65BjVjs4qwskG1tSmf/fD3UF1kXywvYh7nmevDTBu94OUh+cnBmtkMC/j1EpRKBeq6IxcgADCoe9dJJ3u4NBuw5c6n8LMSNXmZHVktvWBTfIqT9RFjtzzgmh3GFK8BsNzrcqW7bqYiJhcardXQBoncSjMbEtLRgtsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elektrobit.com; dmarc=pass action=none
 header.from=elektrobit.com; dkim=pass header.d=elektrobit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elektrobit.onmicrosoft.com; s=selector2-elektrobit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVx2wZczlYGUjjMQ+jyhDN5BpBfxZ1WOUMQcnDTxJ9M=;
 b=cPAAf79ahXzkvZAJsbWJOQd/ma8Q1+H1QKy9VMXHXiGyJPbkLY0nfkKqRZuOX6YHew5JXh9x+zi2YwSFGpg6AvatDzJeNfbvz6XyyZkjcy2eMbfVxUX1UjFsDtLdnRIVwl9+hqn25txdabBNMtcsNcCMvLffaqADbg+5nlnxf9s=
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a4::7) by
 DB8P195MB0646.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:154::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.16; Fri, 26 Aug 2022 08:40:25 +0000
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f]) by DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 08:40:25 +0000
From:   "Lontke, Michael" <Michael.Lontke@elektrobit.com>
To:     "casey@schaufler-ca.com" <casey@schaufler-ca.com>
CC:     "Ostertag, Martin" <Martin.Ostertag@elektrobit.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        =?utf-8?B?V2Vpw58sIFNpbW9uZQ==?= <Simone.Weiss@elektrobit.com>,
        "Valleru, Yuvarajesh" <Yuvarajesh.Valleru@elektrobit.com>,
        "Irgang, Thomas" <Thomas.Irgang@elektrobit.com>
Subject: Re: SMACK LSM checks wrong object label during ingress network
 traffic
Thread-Topic: SMACK LSM checks wrong object label during ingress network
 traffic
Thread-Index: AQHYuGSajWIvX43eyUywpT/36FKxza2/xo0AgAEXoIA=
Date:   Fri, 26 Aug 2022 08:40:24 +0000
Message-ID: <0e3266a5c93229b29c10a0a7b68232000453aabf.camel@elektrobit.com>
References: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
         <7fabf823-bdac-789a-09fb-325e60e79976@schaufler-ca.com>
In-Reply-To: <7fabf823-bdac-789a-09fb-325e60e79976@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elektrobit.com;
X-MS-Office365-Filtering-Correlation-Id: c177c814-efb8-478d-abdf-08da873ea194
x-ms-traffictypediagnostic: DB8P195MB0646:EE_|MW2NAM12FT038:EE_|BN6PR08MB2500:EE_
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: WsTsMEwXykARwJL6kZ7mYOB0Oua8MPkExHE8QXZRHJSMySrahj4vJLu3jLJuUSQnklBPwRofuiZbLr0riQ4Zq9f2XFXRf9B5E1jINPl7o7aF2+q4k/Ml6jHmcTzkabbbOvkTNCqD6SQOBuVTdu0rB9SKVhL4vrzAIBdolSIEmP6mkhDZJuIhKWOv6C0vDQ3brNd57t5rCIBJUtKvKWevU6gR+o3d2gLQnbKLa+Cvf0U+wJFl8wVKBAW7GqdgnBpXF4pJsOFcD90HeLrUVy7E4BsELNeNakOg8GU647H4dUrUodDc00ddcF5fiYPlWIKhIguH4jOenkyzdZAkQDwQexpR86uWSf5hQToEoXYRexvrZq5O9nB0nt/mcgHKPT1xgtJP98PRqXLpHyul5ElmuBWTjfL5o+imCSxpgnMKVAof1NQCOIWQuUp3LzaSmq9jqnze2jzfemGbIBrRdoDTHYxKuXjITKXauYxeFWJRG+egLO9o5S+/S20FFmR+7l9QuJqE4It7AXOp2vNUAri8Y7TAe5pJUftirhP4bzMhBkv8SMhAFNIS7qTxkeHtZeFnSWGp4vRr0Ul5qNWxZTnD4hV6BunMfQzzdwCjUUWWpHbw0m0a+nekgPug92fW23tJVuZAaQsFzubN3CCFeOqS+cgwqGLPkbrxy29xzTF4qa0rReLF9Lqkaoza0ML03yfFKsbHxrt6rWOuKYowfkBqoTs0p8yVuPrcVJgfxRhLwPmQniaVLhhKiSJe6ydmJEQom8MXPv1vz45sKlnBUJwYmw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P195MB1628.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(136003)(346002)(376002)(366004)(396003)(2616005)(83380400001)(6916009)(186003)(71200400001)(316002)(36756003)(107886003)(6506007)(53546011)(6512007)(2906002)(86362001)(38070700005)(66476007)(122000001)(41300700001)(6486002)(4326008)(8936002)(5660300002)(54906003)(38100700002)(8676002)(64756008)(76116006)(91956017)(66446008)(66946007)(66556008)(478600001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE7565E2B9E8A1468992D596A5B02803@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0646
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 539c3d79-4b72-4c03-4994-08da873e9ee6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJ+ahJnDZ5YMYgtzwooRf8DliCWrvHif3QPTC+NGbTnU/PH5Nllo5ZbCJEywZDvJSCSSKKmKpA9jorSDQtYxvXph8LVphur4++2rULeOfdj7cbCPCeiR7JnDWzkIx4fmpfFgw+Ay3P4Dgx3Md8Y+6vYgR29eAd3vOx6BQJ6xsDwSU74tSUY5BxCpHlc1nc7VGsBeS56/x8Ywdx48spsV7LAfMqkFwBOYskvwJtEUEZKAVuxG3kQctnuoM4Cn7YeY8EkPCEQnfEx/onN9LP4v0y8kVJSLRDVn1kcdCnAwt8KPfFwgY2F2Z3FOqi4G0Ug0NsYPeiu4NueLySg3uhvZZaw2AiC/gBFLt6G8vbCR0LhwtUkjU89LWvsH2I+YUk1i9U/F6My8+bfBjf3yf1vKavmVKHjI2NEEP3Bm4UB9wubJrlXaqvR5LRRvfzOTGcVuwX1InQ7IzaI0tsLxHaHrnl3fhiZwI6NzMDGdM0hU8cUO4MchWCxOGLQaCsdPZ+Wj2tXI1kRKB8rTVNcH5qJq6mR5JZurxolHPMi/cuJ7VP9RwZFYzx8rZ8OILCpivyd/gYfihEukv2akurcJ9fCZ+ejFdqbviPOOHGHLbI7N3v0QDdYcJR+U/80NGGQqDBtMKyr54NnrPkdlPYp5OYZ3EWS0dkImmsXMsR9mUICOHlRitbI2y4vHLVQgqyzan27E6nEtRMvsgeMxkdrP+Eee9V6ap38S1DvmkyXBTCbga49GRONimo7n94oYv16/3HXZiSXWTor7OdZo0kFMjKUbEFkCxVqPOhiu/qkosZTrUjle0w1vd1tSYD3E7AYeXahl
X-Forefront-Antispam-Report: CIP:4.79.107.243;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(396003)(346002)(376002)(46966006)(36840700001)(40470700004)(70206006)(70586007)(40480700001)(82310400005)(6506007)(107886003)(8936002)(2906002)(8676002)(36756003)(41300700001)(5660300002)(478600001)(6486002)(4326008)(6916009)(316002)(54906003)(186003)(6512007)(336012)(26005)(47076005)(2616005)(53546011)(83380400001)(40460700003)(36860700001)(356005)(81166007)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 08:40:29.4474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c177c814-efb8-478d-abdf-08da873ea194
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR08MB2500
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVGh1LCAyMDIyLTA4LTI1IGF0IDA4OjU5IC0wNzAwLCBDYXNleSBTY2hhdWZsZXIgd3JvdGU6
DQo+IE9uIDgvMjUvMjAyMiAyOjI1IEFNLCBMb250a2UsIE1pY2hhZWwgd3JvdGU6DQo+ID4gSGVs
bG8gTXIuIFNjaGF1ZmxlciwNCj4gPiANCj4gPiB3ZSBvYnNlcnZlZCB0aGUgZm9sbG93aW5nIGJl
aGF2aW9yIG9mIHRoZSBTTUFDSyBMU00ga2VybmVsIGZlYXR1cmUuDQo+ID4gDQo+ID4gUFJPQkxF
TTogU01BQ0sgTFNNIGlzIGNoZWNraW5nIHRoZSB3cm9uZyBsYWJlbCB3aGVuIHJlY2VpdmluZw0K
PiA+IG5ldHdvcmsNCj4gPiBwYWNrZXRzIGR1cmluZyBoaWdoIHN5c3RlbSBsb2FkLg0KPiA+IA0K
PiA+IEZ1bGwgRGVzY3JwaXRpb24gb2YgdGhlIFByb2JsZW06IER1cmluZyBhIHRlc3Qgc2NlbmFy
aW8gaW52b2x2aW5nDQo+ID4gaGlnaA0KPiA+IHN5c3RlbSBsb2FkIChjcHUsIG1lbW9yeSBhbmQg
aW8pIGluIGNvbWJpbmF0aW9uIHdpdGggaW5ncmVzcyB0Y3ANCj4gPiBuZXR3b3JrIHRyYWZmaWMs
IFNNQUNLIGlzIGNoZWNraW5nIHdyb25nIG9iamVjdCBsYWJlbHMgbGVhZGluZyB0bw0KPiA+IGRl
bmllZCBhY2Nlc3MgZm9yIHZhbGlkIHNjZW5hcmlvcy4NCj4gPiBJbiBiZWxvdyB0ZXN0IHNjZW5h
cmlvIHRoZSBsYWJlbCAnc3RyZXNzdGVzdCcgaXMgb25seSB1c2VkIGZvciB0aGUNCj4gPiBhcHBs
aWNhdGlvbiAnc3RyZXNzJyBidXQgYXBwZWFycyBpbiBTTUFDSyBhdWRpdCBsb2dzIGFzIG9iamVj
dA0KPiA+IHRvZ2V0aGVyDQo+ID4gd2l0aCBuZXRsYWJlbHMuDQo+ID4gDQo+ID4gVGhpcyBpc3N1
ZSBpbml0aWFsbHkgYXBwZWFyZWQgb24gaGFyZHdhcmUgd2l0aCBrZXJuZWwgdmVyc2lvbg0KPiA+
IDQuMTQuMjM3DQo+ID4gYnV0IHdhcyBhbHNvIGJlaW5nIHJlcHJvZHVjZWQgd2l0aCBxZW11IGZv
ciBrZXJuZWwgdmVyc2lvbiA0LjE0LjI5MA0KPiA+IGFuZA0KPiA+IGxhdGVzdCA2LjAtcmMyLiBU
aGUgdXNlZCByb290ZnMgd2FzIGdlbmVyYXRlZCB2aWEgYnVpbGRyb290IHZlcnNpb24NCj4gPiAy
MDIyLjA4LXJjMS4NCj4gPiANCj4gPiANCj4gPiBLRVlXT1JEUzogc21hY2ssIG5ldHdvcmtpbmcN
Cj4gPiANCj4gPiBLRVJORUwgSU5GT1JNQVRJT046IExpbnV4IHN0YWJsZSBrZXJuZWwNCj4gPiAN
Cj4gPiBLRVJORUwgVkVSU0lPTjogNC4xNC4yMzcsIDQuMTQuMjkwLCA2LjAtcmMyDQo+ID4gDQo+
ID4gDQo+ID4gS0VSTkVMIENPTkZJRzogc21hY2sgcmVsYXRlZCBrZXJuZWwgY29uZmlndXJhdGlv
bg0KPiA+IA0KPiA+IENPTkZJR19ORVRMQUJFTD15DQo+ID4gDQo+ID4gQ09ORklHX1NFQ1VSSVRZ
X05FVFdPUks9eQ0KPiA+IA0KPiA+IENPTkZJR19TRUNVUklUWV9TTUFDSz15DQo+ID4gDQo+ID4g
Q09ORklHX0RFRkFVTFRfU0VDVVJJVFlfU01BQ0s9eQ0KPiA+IA0KPiA+IENPTkZJR19ERUZBVUxU
X1NFQ1VSSVRZPSJzbWFjayINCj4gDQo+IFdoYXQgaXMgdGhlIHZhbHVlIGZvciBDT05GSUdfU0VD
VVJJVFlfU01BQ0tfTkVURklMVEVSID8NCg0KIyBDT05GSUdfTkVUV09SS19TRUNNQVJLIGlzIG5v
dCBzZXQNCnRoZXJlZm9yZSBDT05GSUdfU0VDVVJJVFlfU01BQ0tfTkVURklMVEVSIGlzIG5vdCBz
ZXQgYXMgd2VsbC4NCg0KPiBUaGUgaW1wbGVtZW50YXRpb24gZm9yIElQdjYgaXMgbXVjaCBtb3Jl
IHJvYnVzdCBmb3IgdGhlDQo+IG5ldGZpbHRlciBlbmFibGVkIHBhdGguDQoNCllvdSBhcmUgc3Rh
dGluZyB0aGF0DQoNCkNPTkZJR19ORVRXT1JLX1NFQ01BUks9eQ0KQ09ORklHX1NFQ1VSSVRZX1NN
QUNLX05FVEZJTFRFUj15DQoNCmFuZCB0aGVyZWZvcmUgdXNpbmcgU01BQ0tfSVBWNl9TRUNNQVJL
X0xBQkVMSU5HIGluc3RlYWQgb2YNClNNQUNLX0lQVjZfUE9SVF9MQUJFTElORyBwYXRoIGluIGtl
cm5lbCBjb2RlIGlzIG1vcmUgcmVsaWFibGU/DQoNCj4gDQo+ID4gQ09ORklHX0NSQ19DQ0lUVD15
DQo+ID4gDQo+ID4gQ09ORklHX0VYVDRfRlNfU0VDVVJJVFk9eQ0KPiA+IA0KPiA+IENPTkZJR19U
TVBGU19YQVRUUj15DQo+ID4gDQo+ID4gQ09ORklHX1NRVUFTSEZTX1hBVFRSPXkNCj4gPiANCj4g
PiANCj4gPiBTdGVwcyB0byByZXByb2R1Y2UgdGhlIGlzc3VlOg0KPiANCj4gVGhhbmsgeW91IGZv
ciB0aGUgZGV0YWlsZWQgcmVwb3J0LiBJIHdpbGwgbG9vayBpbnRvDQo+IHRoZSBwcm9ibGVtIHRv
ZGF5Lg0KPiANCj4gPiBPbiBxZW11Og0KPiA+ICogU2V0dXAgcWVtdSB3aXRoIG5ldHdvcmsgY29u
bmVjdGlvbiB0byB0aGUgaG9zdCB2aWEgdGFwIGRldmljZS4NCj4gPiAqIEFkZCBpcDZob3N0IGxh
YmVsIHZpYSBzbWFja2ZzOg0KPiA+IA0KPiA+IGVjaG8gIjxob3N0LWlwdjYtYWRkcj4gbmV0X2hv
c3QiID4gL3N5cy9mcy9zbWFja2ZzL2lwdjZob3N0DQo+ID4gDQo+ID4gKiBBZGQgcnVsZSBmb3Ig
YWxsb3dlZCBuZXR3b3JrIHRyYWZmaWM6DQo+ID4gDQo+ID4gZWNobyAidGNwX3Rlc3QgbmV0X2hv
c3QgdyIgPiAvc3lzL2ZzL3NtYWNrZnMvbG9hZDINCj4gPiANCj4gPiAqIFRoZSBmb2xsb3dpbmcg
c2NyaXB0IHdhcyB1c2VkIGZvciBsaXN0ZW5pbmcgZm9yIHBhY2tldHMgb24gcWVtdToNCj4gPiAN
Cj4gPiBjYXQgPDwgRU9GID4gdGNwX2xpc3Rlbi5zaA0KPiA+ICMhL2Jpbi9zaA0KPiA+IHdoaWxl
IHRydWU7DQo+ID4gZG8NCj4gPiAgICAgc29jYXQgLSBUQ1A2LUxJU1RFTjpcJDEscmV1c2VhZGRy
LGZvcmsgPiAvZGV2L251bGwgJiBwcz1cJCENCj4gPiAgICAgc2xlZXAgMQ0KPiA+ICAgICBraWxs
IC05IFwkcHMNCj4gPiBkb25lDQo+ID4gRU9GDQo+ID4gDQo+ID4gKiBTdGFydCB0aGUgc2NyaXB0
IHR3aWNlLCBvbmUgYWxsb3dpbmcsIG9uZSBkZW55aW5nIHRyYWZmaWMgdmlhDQo+ID4gU01BQ0s6
DQo+ID4gDQo+ID4gZWNobyB0Y3BfdGVzdCA+IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50ICYmIHNo
IHRjcF9saXN0ZW4uc2ggMTIzNDUNCj4gPiAyPiYxDQo+ID4gL2Rldi9udWxsICYNCj4gPiBlY2hv
IHRjcF90ZXN0MiA+IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50ICYmIHNoIHRjcF9saXN0ZW4uc2gg
MTIzNDYNCj4gPiAyPiYxDQo+ID4gL2Rldi9udWxsICYNCj4gPiANCj4gPiAqIFN0YXJ0ICdzdHJl
c3MnIHRvIGdlbmVyYXRlIHN5c3RlbSBsb2FkIHdpdGggJ3N0cmVzc3Rlc3QnIGFzIFNNQUNLDQo+
ID4gbGFiZWw6DQo+ID4gDQo+ID4gZWNobyBzdHJlc3N0ZXN0ID4gL3Byb2Mvc2VsZi9hdHRyL2N1
cnJlbnQgJiYgc3RyZXNzIC1jIDIgLWkgNCAtbSAyDQo+ID4gLS0NCj4gPiB2bS1ieXRlcyA2NE0g
Jg0KPiA+IA0KPiA+IA0KPiA+IE9uIGhvc3Q6DQo+ID4gKiBHZW5lcmF0ZSByYW5kb20gZGF0YSB0
byBzZW5kIHZpYSBuZXR3b3JrOg0KPiA+IA0KPiA+IGRkIGlmPS9kZXYvdXJhbmRvbSBvZj10ZXN0
L2RhdGEgYnM9MU0gY291bnQ9MTANCj4gPiANCj4gPiAqIFVzZSB0aGUgZm9sbG93aW5nIHNjcmlw
dCB0byBjb250aW5vdXNseSBzZW5kIHBhY2tldHM6DQo+ID4gDQo+ID4gY2F0IDw8IEVPRiA+IHBh
Y2tldF90Y3Auc2gNCj4gPiAjIS9iaW4vc2gNCj4gPiB3aGlsZSB0cnVlOw0KPiA+IGRvDQo+ID4g
ICAgIGNhdCBkYXRhIHwgbmMgPHFlbXUtaXB2Ni1hZGRyPiBcJDENCj4gPiBkb25lDQo+ID4gRU9G
DQo+ID4gDQo+ID4gKiBFeGVjdXRlIHRoZSBzY3JpcHQgdHdpY2UgdG8gYWRkcmVzcyBib3RoIHJl
Y2VpdmluZyBhcHBsaWNhdGlvbnMNCj4gPiBvbg0KPiA+IHFlbXU6DQo+ID4gDQo+ID4gYmFzaCBw
YWNrZXRfdGNwLnNoIDEyMzQ1IDI+JjEgPiAvZGV2L251bGwgJg0KPiA+IGJhc2ggcGFja2V0X3Rj
cC5zaCAxMjM0NiAyPiYxID4gL2Rldi9udWxsICYNCj4gPiANCj4gPiANCj4gPiBPYnNlcnZpbmcg
dGhlIHByb2JsZW06DQo+ID4gDQo+ID4gQWZ0ZXIgbGV0dGluZyB0aGlzIHJ1biBmb3IgfjUtMTAg
bWlucyBvbmx5IGF1ZGl0IG1lc3NhZ2VzIHJlZ2FyZGluZw0KPiA+IHRoZQ0KPiA+IGxhYmVsICd0
Y3BfdGVzdDInIGFyZSBleHBlY3RlZC4NCj4gPiBUaGUgaXNzdWVzIGNhbiBiZSBzZWVuLCB0aGF0
IGFsc28gb3RoZXIgbGFiZWxzIGFyZSByYW5kb21seQ0KPiA+IGFwcGVhcmluZw0KPiA+IGluIHRo
ZSBsb2dzIChtb3N0IGNvbW1vbmx5IGhlcmUgJ3N0cmVzc3Rlc3QnLCBwcm9iYWJseSBzaW5jZSBp
dA0KPiA+IG9jY3VwaWVzIG1vc3Qgb2YgdGhlIGNwdSB0aW1lKToNCj4gPiANCj4gPiBqb3VybmFs
Y3RsIHwgZ3JlcCBhY3Rpb249ZGVuaWVkIHwgZ3JlcCAtdiB0Y3BfdGVzdDINCj4gPiANCj4gPiAN
Cj4gPiBFeGFtcGxlIGVudHJ5IHdpdGgga2VybmVsIDYuMC1yYzI6DQo+ID4gQXVnIDI0IDEyOjM4
OjMyIGJ1aWxkcm9vdCBhdWRpdFs2MDldOiBBVkMgbHNtPVNNQUNLDQo+ID4gZm49c21rX2lwdjZf
Y2hlY2sNCj4gPiBhY3Rpb249ZGVuaWVkIHN1YmplY3Q9Im5ldF9ob3N0IiBvYmplY3Q9InN0cmVz
c3Rlc3QiIHJlcXVlc3RlZD13DQo+ID4gcGlkPTYwOSBjb21tPSJzdHJlc3MiIHNhZGRyPTxob3N0
LWlwdjYtYWRkcj4gZGVzdD01MDcxNA0KPiANCj4gVGhpcyBtYXkgYmUgYW4gaXNzdWUgd2l0aCB0
aGUgYXVkaXQgcmVjb3JkIGdlbmVyYXRpb24gaW5jbHVkaW5nIHRoZQ0KPiB3cm9uZyBvYmplY3Qg
bGFiZWwuIEl0IGhhcyBiZWVuIG5vdGljZWQgYmVmb3JlLiBJIHdpbGwgbG9vayBtb3JlDQo+IGNs
b3NlbHkuDQo+IA0KPiA+IElmIHlvdSBhcmUgbWlzc2luZyBhZGRpdGlvbmFsIGluZm8gcGxlYXNl
IHJlYWNoIG91dCB0byBtZS4NCj4gPiBUaGFuayB5b3UgaW4gYWR2YW5jZSBhbmQgYmVzdCByZWdh
cmRzLA0KPiA+IA0KPiA+IE1pY2hhZWwgTG9udGtlDQo=
