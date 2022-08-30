Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F933ECAAA1
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Aug 2022 09:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiH3JaZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH3JaY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Aug 2022 05:30:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410974D4EE
        for <linux-security-module@vger.kernel.org>; Tue, 30 Aug 2022 02:30:23 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=L7bOUW1iuOyiLt5PlOlPYgZCTQ7zAbO7twWaDGtd+QgRJGY8DZOVjy+sHREncx0Aob+VaQ+7/khhCavxZOtQ2cgwlVQAoOa6yqqBD/Irfs/8ex3EWuIFUBM9fO7RUBh2+B1Qe5ij/iRfO03iI10ntKqWbdHipNC85gzEY8nkiEHiNGa7QuKAH6s1/B/2dBZK+SS/qBcp1TA+turn0Pb398/iDBazvj17rfc+x9O8ZACQVakUj3b3xeX32x2PKeGiGoiw0UUPU3lK0DPOYAN4Vsjz8MccJj3UHE0kzQ/ONrDEtCi4Z+Fil1J4o6YFQAXGcWOFzdCX9DMtOQJ53cE7kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoOUG76O686aYgTqtlLXuytEZJqVVQTEaK5hrmWZ75Y=;
 b=Zk8hgVzJxcOFRc1aL0RdYRIAYVhdyupkFpgdswhybOLhjzPyfv9OdeY3fAja/qBBlq/LGoJgzmtWg7Wejkyck4ylVpckwvYXDJYYdmFu4K7hk2woDUkq9ERKnLunVnPoABO901AELQdQrx6UGccFguk7+/QLO6FgO4L3WCSdRWeFio60GxKtzcw2GmIRSi0oEjgcIev7fhjBZB3L0yHsm0M1eQKYgEbpk2xze5+wjC3hnzIlxYXMwcRhQiGBdMAxoHXm2sXueOEgoedeG/1QtlcoZKiRzkGOiyWrJWZpf96igkzPHUUHfhZU8fzvT0liMoJJNxZejqA8hiq9b+cdMQ==
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
 bh=BoOUG76O686aYgTqtlLXuytEZJqVVQTEaK5hrmWZ75Y=;
 b=qa97NaHuKQd0ezSHyNkGftaSX2PbEgMw9uyXd1XHIPzzyHl/J0tHhGgSdbiF9RwZDRIpFvRDhvtuFTPvtZrsRt5qbWUF+BY1t9jpk/PLZ30mqJSR4obasrbDyBrSKcYsz0Ocdzj2a+ltcGICkfZ6cyduPS9derlwL5qvpmU6d4I=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by DM5PR0801MB3783.namprd08.prod.outlook.com (2603:10b6:4:76::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 09:30:21 +0000
Received: from MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::d4) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 09:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.onmicrosoft.com;dmarc=fail action=none
 header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 4.79.107.243 as permitted sender)
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 MW2NAM12FT051.mail.protection.outlook.com (10.13.181.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.3 via Frontend Transport; Tue, 30 Aug 2022 09:30:21 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
        Tue, 30 Aug 2022 02:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh9jMrz5WmPhhB/tHDmvSrKPRbBJgfKS/gPseIW1oL8Afv2OAiFhk4ormaNhNmFzzM85D1uanQJbECVk0Q7drtcnS3j0hR6k8/QW5aO4jV8ych3Qdh3V8tpW//FBri3gBYqjfAjvjbfD/l5GI0mDTtdyxtmECsMIiPbgLuQSxnHS7VesU8kG5ISWGClesbkU9o+QifIrS8WFL45QLKh6f7gIsKBoabcjcNsk4tU47e2Ps+a2mChx4iTTDOH3jqQ2v3doB4/OrZ7f7+StyCRer/KFyw5Hs3/iZtAKuS02zajJtftoGuDwDePZyE50PLan8fiJYBlITE3s+Z4d2a9o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoOUG76O686aYgTqtlLXuytEZJqVVQTEaK5hrmWZ75Y=;
 b=KVQrHHfcQRdhzUXkKoRN0K1wiHPxJXSQtSHBDN8aV2c6aHoMMMvo+dM54gjHIuPbKdzClH7zqtPVQQMkuNYcTnQ+dDL95oTQVAvsi6xpc0F28yEhJBYUdz2Bz6r7RAq4J2/0lBK24BTJu6b2zxdK1qtmvpjnljmm8mPJLSTtzUAp7Rt2kM7ngCNb/GfIUOvLD9VxK3EmGLW3Z15AWzzSxFqNH+bTClWju1MW5PLcf4pYJ36ndsTJRhKJOW+sT13xe/xmhulHuZfJvOC4wnPwxltiBKV3nEdR5Gz80BlC2HsDDc2owqojcsJffnuHjb5LMl54k0YMqqJB0E5VXwX0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elektrobit.com; dmarc=pass action=none
 header.from=elektrobit.com; dkim=pass header.d=elektrobit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elektrobit.onmicrosoft.com; s=selector2-elektrobit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoOUG76O686aYgTqtlLXuytEZJqVVQTEaK5hrmWZ75Y=;
 b=qa97NaHuKQd0ezSHyNkGftaSX2PbEgMw9uyXd1XHIPzzyHl/J0tHhGgSdbiF9RwZDRIpFvRDhvtuFTPvtZrsRt5qbWUF+BY1t9jpk/PLZ30mqJSR4obasrbDyBrSKcYsz0Ocdzj2a+ltcGICkfZ6cyduPS9derlwL5qvpmU6d4I=
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a4::7) by
 DB9P195MB2107.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Tue, 30 Aug 2022 09:30:17 +0000
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f]) by DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 09:30:17 +0000
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
Thread-Index: AQHYuGSajWIvX43eyUywpT/36FKxza2/xo0AgAEXoICAAH8fAIAF2CQA
Date:   Tue, 30 Aug 2022 09:30:17 +0000
Message-ID: <61f18d5513bdb68748e635470a41eb4e2dadb915.camel@elektrobit.com>
References: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
         <7fabf823-bdac-789a-09fb-325e60e79976@schaufler-ca.com>
         <0e3266a5c93229b29c10a0a7b68232000453aabf.camel@elektrobit.com>
         <2d4958bd-dc67-8244-c688-eed4feb64ba8@schaufler-ca.com>
In-Reply-To: <2d4958bd-dc67-8244-c688-eed4feb64ba8@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elektrobit.com;
X-MS-Office365-Filtering-Correlation-Id: da4e12ff-1898-42ac-add3-08da8a6a425c
x-ms-traffictypediagnostic: DB9P195MB2107:EE_|MW2NAM12FT051:EE_|DM5PR0801MB3783:EE_
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: P00rxCYVviC+7K1zmsmHwmV2xW3iW0lCs0Oi4oCS77Aw7i/qT2MSvVR2JFTPT9YTEKycUPLnOA31XSqgVXMThEdfayi8//Fa0tltpyvUNUUVIssu6xm3fa5EP6G120992qBAnC9gghAQ5hX6/potTCk0UFOqxa4dWZVFHqV3HogH6AX7XoclEZDXPCespEmd9sXrtICjRSZxreQ8730bLHSShPcl8YyFFeLvEj9Dhi7AaHsKICXRSLY4KMh4KuYLsxxvnl8irmH7mUwEaRDmKAzzN/uoX1r8GjXQnBqZqiDN33YxPZkEG5lcyqP8e4SSIAhbNxQeTzsUf3C5gBd90RStKcZMTIh54pYLVCNB9UCSGvAgvvaqySsLkZWVM1+wKAbDcO9oUmtY8vbnLVcKYPeJyqrc+SrI10oz0iv82z7jTMHg342Ky5HntLTcCFqfEcnUnyDX92kD6PXeHeXtfouUGieXi4eUWXyU5mFblY8TRvwANpqEMJN+URXE/u+GrgRdxIL6Rd/n+7jy++XPhn4l2ayODP0RBB9a+17hy2zwLt+M4yq3O0uMB2NAtoJJaos35t6i9KZU9ShNlBomb0A4ubub3gZMipZH8AEqUDGe3r8GfvNRTe3wtJohIybAPfbsrhPjgHRT0DaE3HoKSqjGz4AxLvlQ28t2U7aIbsE9uWxOVz4A3788FGJvSEkJC7SExhVWaSX6ccPYT/tC0RU4cU+LvqejORS8NFFtaN9Hv4bebvHpG+oUh+L8mxjGDNKWj1jC7KkFmgPxHItXlg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P195MB1628.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(6506007)(122000001)(53546011)(38100700002)(2906002)(107886003)(2616005)(186003)(6512007)(83380400001)(86362001)(4326008)(66946007)(71200400001)(66446008)(64756008)(76116006)(8676002)(6486002)(66556008)(66476007)(91956017)(54906003)(316002)(6916009)(36756003)(8936002)(38070700005)(41300700001)(478600001)(5660300002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE44CBB6AFB1CD4EB972105E6FB43E09@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2107
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ffeab675-24fe-4200-7c52-08da8a6a4007
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SlFevvGXAN9tcHK5vmXfc+lO1Q2m12GB10WwVMkw2vbc1RMGqK9hGLAom7SWLFYkx/IlPh1juqwmHRs6Qmt+0lu6sm7Qdn+fCn0V/+ppCqy7T2oOQQVNdLsrs7YurQcP/zJuPlEyx2aPSX6nubSEzvqLT79E1g2/j3kDFEZgbsF449OBr+OJRU0q22Pb/t1Cvmi3TNHKzpSoCn6pwrDegi8YpRPV/H3mGnF2d6RcNG3E6Q5pKzj6bljVSDFNIsTobwHOpezc75JFXdXyfKT8Rw4T6JGEenwrw8jIPGaPA+lGzq7rx+ZSx48/KojQOjTeiEZ5b0Stitqxgh0YU0Nky0S0cJGklgPnx1fdS5QddYFm9mtVIHLJ6xg6fP2GciSO8yH/ISzOOe6S9CuH7Dr+xfo+69PhGl7Ofkqc9nQXS9jK/x03B9CxNISHh+YRDaLjK2xABAq7J99xYFwWHvOKuozBYnst0wMUz7KDHh5rf6nyvPiUnvmLKOeRB+bd4TuxjmPb7g2xaM7JOVxmgNePNVt+f3rnx4txvywY2uUp3Qnd3VdiokyNCWkP0cHa2FbziO6+8umuZ8KdijdwWT7qAlT06Oo0bdSlRTgacGSZVrFFbOxZjwZlZOEoQ0nmPe63rHSVUuuBzcIUMH8fh95xtL/udu/bwyc0OEKAbAqWe9NyYVlZgz2CY/OKF+MyB381+w4T6VuYmYtD0EB+/FAYMYO/zGe7njXg5R19xKDqK5t1Ylmn1mThk+NdMVVwnSSBvEQxGWnC0NqsX1dOD7YiOgfK3nUh50E7RpOrTx8XNOqWbL6f56pM6A3WpUYhqrV
X-Forefront-Antispam-Report: CIP:4.79.107.243;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(136003)(376002)(396003)(346002)(46966006)(40470700004)(36840700001)(336012)(70206006)(82740400003)(356005)(316002)(81166007)(70586007)(82310400005)(36756003)(2616005)(47076005)(40480700001)(6486002)(478600001)(36860700001)(41300700001)(83380400001)(6512007)(40460700003)(54906003)(4326008)(8936002)(107886003)(53546011)(26005)(86362001)(2906002)(6916009)(8676002)(186003)(6506007)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 09:30:21.0414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4e12ff-1898-42ac-add3-08da8a6a425c
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0801MB3783
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDA5OjE1IC0wNzAwLCBDYXNleSBTY2hhdWZsZXIgd3JvdGU6
DQo+IE9uIDgvMjYvMjAyMiAxOjQwIEFNLCBMb250a2UsIE1pY2hhZWwgd3JvdGU6DQo+ID4gT24g
VGh1LCAyMDIyLTA4LTI1IGF0IDA4OjU5IC0wNzAwLCBDYXNleSBTY2hhdWZsZXIgd3JvdGU6DQo+
ID4gPiBPbiA4LzI1LzIwMjIgMjoyNSBBTSwgTG9udGtlLCBNaWNoYWVsIHdyb3RlOg0KPiA+ID4g
PiBIZWxsbyBNci4gU2NoYXVmbGVyLA0KPiA+ID4gPiANCj4gPiA+ID4gd2Ugb2JzZXJ2ZWQgdGhl
IGZvbGxvd2luZyBiZWhhdmlvciBvZiB0aGUgU01BQ0sgTFNNIGtlcm5lbA0KPiA+ID4gPiBmZWF0
dXJlLg0KPiA+ID4gPiANCj4gPiA+ID4gUFJPQkxFTTogU01BQ0sgTFNNIGlzIGNoZWNraW5nIHRo
ZSB3cm9uZyBsYWJlbCB3aGVuIHJlY2VpdmluZw0KPiA+ID4gPiBuZXR3b3JrDQo+ID4gPiA+IHBh
Y2tldHMgZHVyaW5nIGhpZ2ggc3lzdGVtIGxvYWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBGdWxsIERl
c2NycGl0aW9uIG9mIHRoZSBQcm9ibGVtOiBEdXJpbmcgYSB0ZXN0IHNjZW5hcmlvDQo+ID4gPiA+
IGludm9sdmluZw0KPiA+ID4gPiBoaWdoDQo+ID4gPiA+IHN5c3RlbSBsb2FkIChjcHUsIG1lbW9y
eSBhbmQgaW8pIGluIGNvbWJpbmF0aW9uIHdpdGggaW5ncmVzcw0KPiA+ID4gPiB0Y3ANCj4gPiA+
ID4gbmV0d29yayB0cmFmZmljLCBTTUFDSyBpcyBjaGVja2luZyB3cm9uZyBvYmplY3QgbGFiZWxz
IGxlYWRpbmcNCj4gPiA+ID4gdG8NCj4gPiA+ID4gZGVuaWVkIGFjY2VzcyBmb3IgdmFsaWQgc2Nl
bmFyaW9zLg0KPiA+ID4gPiBJbiBiZWxvdyB0ZXN0IHNjZW5hcmlvIHRoZSBsYWJlbCAnc3RyZXNz
dGVzdCcgaXMgb25seSB1c2VkIGZvcg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gYXBwbGljYXRpb24g
J3N0cmVzcycgYnV0IGFwcGVhcnMgaW4gU01BQ0sgYXVkaXQgbG9ncyBhcyBvYmplY3QNCj4gPiA+
ID4gdG9nZXRoZXINCj4gPiA+ID4gd2l0aCBuZXRsYWJlbHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBU
aGlzIGlzc3VlIGluaXRpYWxseSBhcHBlYXJlZCBvbiBoYXJkd2FyZSB3aXRoIGtlcm5lbCB2ZXJz
aW9uDQo+ID4gPiA+IDQuMTQuMjM3DQo+ID4gPiA+IGJ1dCB3YXMgYWxzbyBiZWluZyByZXByb2R1
Y2VkIHdpdGggcWVtdSBmb3Iga2VybmVsIHZlcnNpb24NCj4gPiA+ID4gNC4xNC4yOTANCj4gPiA+
ID4gYW5kDQo+ID4gPiA+IGxhdGVzdCA2LjAtcmMyLiBUaGUgdXNlZCByb290ZnMgd2FzIGdlbmVy
YXRlZCB2aWEgYnVpbGRyb290DQo+ID4gPiA+IHZlcnNpb24NCj4gPiA+ID4gMjAyMi4wOC1yYzEu
DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gS0VZV09SRFM6IHNtYWNrLCBuZXR3b3JraW5n
DQo+ID4gPiA+IA0KPiA+ID4gPiBLRVJORUwgSU5GT1JNQVRJT046IExpbnV4IHN0YWJsZSBrZXJu
ZWwNCj4gPiA+ID4gDQo+ID4gPiA+IEtFUk5FTCBWRVJTSU9OOiA0LjE0LjIzNywgNC4xNC4yOTAs
IDYuMC1yYzINCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBLRVJORUwgQ09ORklHOiBzbWFj
ayByZWxhdGVkIGtlcm5lbCBjb25maWd1cmF0aW9uDQo+ID4gPiA+IA0KPiA+ID4gPiBDT05GSUdf
TkVUTEFCRUw9eQ0KPiA+ID4gPiANCj4gPiA+ID4gQ09ORklHX1NFQ1VSSVRZX05FVFdPUks9eQ0K
PiA+ID4gPiANCj4gPiA+ID4gQ09ORklHX1NFQ1VSSVRZX1NNQUNLPXkNCj4gPiA+ID4gDQo+ID4g
PiA+IENPTkZJR19ERUZBVUxUX1NFQ1VSSVRZX1NNQUNLPXkNCj4gPiA+ID4gDQo+ID4gPiA+IENP
TkZJR19ERUZBVUxUX1NFQ1VSSVRZPSJzbWFjayINCj4gPiA+IA0KPiA+ID4gV2hhdCBpcyB0aGUg
dmFsdWUgZm9yIENPTkZJR19TRUNVUklUWV9TTUFDS19ORVRGSUxURVIgPw0KPiA+IA0KPiA+ICMg
Q09ORklHX05FVFdPUktfU0VDTUFSSyBpcyBub3Qgc2V0DQo+ID4gdGhlcmVmb3JlIENPTkZJR19T
RUNVUklUWV9TTUFDS19ORVRGSUxURVIgaXMgbm90IHNldCBhcyB3ZWxsLg0KPiA+IA0KPiA+ID4g
VGhlIGltcGxlbWVudGF0aW9uIGZvciBJUHY2IGlzIG11Y2ggbW9yZSByb2J1c3QgZm9yIHRoZQ0K
PiA+ID4gbmV0ZmlsdGVyIGVuYWJsZWQgcGF0aC4NCj4gPiANCj4gPiBZb3UgYXJlIHN0YXRpbmcg
dGhhdA0KPiA+IA0KPiA+IENPTkZJR19ORVRXT1JLX1NFQ01BUks9eQ0KPiA+IENPTkZJR19TRUNV
UklUWV9TTUFDS19ORVRGSUxURVI9eQ0KPiA+IA0KPiA+IGFuZCB0aGVyZWZvcmUgdXNpbmcgU01B
Q0tfSVBWNl9TRUNNQVJLX0xBQkVMSU5HIGluc3RlYWQgb2YNCj4gPiBTTUFDS19JUFY2X1BPUlRf
TEFCRUxJTkcgcGF0aCBpbiBrZXJuZWwgY29kZSBpcyBtb3JlIHJlbGlhYmxlPw0KPiANCj4gWWVz
LiBUaGUgbmV0ZmlsdGVyIHZlcnNpb24gaXMgdXNlZCBpbiBhbGwga25vd24gY29tbWVyY2lhbA0K
PiBkZXBsb3ltZW50cw0KPiBvZiBTbWFjaywgYW5kIGhlbmNlIGhhcyBnb3R0ZW4gbW9yZSBhdHRl
bnRpb24uIFRoZSBwb3J0IGxhYmVsaW5nIGNvZGUNCj4gaXMgYSAiY2xldmVyIGhhY2siLiBJIGhv
cGUgdG8gcmVwbGFjZSBpdCB3aXRoIENBTElQU08gbm93IHRoYXQNCj4gQ0FMSVBTTw0KPiBpcyBz
dXBwb3J0ZWQgYnkgbmV3bGFiZWwuDQo+IA0KDQpUb2RheSBJIHRlc3RlZCB3aXRoIHlvdXIgc3Vn
Z2VzdGVkIGNvbmZpZ3VyYXRpb24gKHNlY21hcmsgKyBuZXRmaWx0ZXIpLg0KRXhlY3V0aW5nIHRo
ZSBzYW1lIHRlc3QgY2FzZSBJIHJ1biBpbnRvIGFsbW9zdCB0aGUgc2FtZSBpc3N1ZToNCg0KWyAg
Mjg4LjIwMDIwNl0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNjYxODQ0MDY5LjM3Njo3NDIpOiBs
c209U01BQ0sNCmZuPXNtYWNrX3NvY2tldF9zb2NrX3Jjdl9za2IgYWN0aW9uPWRlbmllZCBzdWJq
ZWN0PSJuZXRfaG9zdCINCm9iamVjdD0ic3RyZXNzdGVzdCIgcmVxdWVzdGVkPXcgcGlkPTE4NSBj
b21tPSJzdHJlc3MiIHNhZGRyPTxob3N0LWlwdjYtDQphZGRyPiBzcmM9NDk4MTIgZGFkZHI9PHFl
bXUtaXB2Ni1hZGRyPiBkZXN0PTQyNTExIG5ldGlmPWVuczMNCg0KSW5zdGVhZCBvZiBkZWZpbmlu
ZyB0aGUgbmV0bGFiZWwgdmlhIC9zeXMvZnMvc21hY2tmcy9pcDZob3N0cyBJIGFkZGVkIGENCm5l
dGZpbHRlciBydWxlIHRvIG1hcmsgdGhlIHBhY2thZ2Ugd2l0aCBzZWNtYXJrOg0KDQppcDZ0YWJs
ZXMgLXQgbWFuZ2xlIC1BIElOUFVUIC1wIHRjcCAtLXNyYyA8aG9zdC1pcHY2LWFkZHI+IC1qIFNF
Q01BUksNCi0tc2VsY3R4IG5ldF9ob3N0DQoNCg==
