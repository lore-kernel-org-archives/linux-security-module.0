Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69979C43387
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 02:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDA82086D
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 02:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DluY49Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfARCk4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:40:56 -0500
Received: from mail-eopbgr690065.outbound.protection.outlook.com ([40.107.69.65]:22714
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbfARCk4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Jan 2019 21:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saPKyQ/UFkWGWCskg/5OMrvn8NuwBBAiLIvqXoBzM0I=;
 b=DluY49LsCgJEPGSFLJS1adJ0XdhS8j1VdM2o3v2LRyJ6Zl7Oy8yzgxUPEEMbVduOOjj+Y0OHThlSSZ9tWyRpovFdOPQBTFD1fvOWAt3rrBXotqeHMaT4weswzdegSpF8BYD177vymwmnsafTTf/t4dF5ZLV5xA2THpVujrG8Fi4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6118.namprd05.prod.outlook.com (20.178.54.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.8; Fri, 18 Jan 2019 02:40:52 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 02:40:52 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LSM List <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/17] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Topic: [PATCH 01/17] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Index: AQHUrfxOhBIE3CgBbEWQpABmYJlN26WzBO2AgADywwCAABdJAIAABZCAgAAFwwCAADgugA==
Date:   Fri, 18 Jan 2019 02:40:52 +0000
Message-ID: <1F75B04B-1A2D-4A5A-99BC-89F5DAF6A83B@vmware.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-2-rick.p.edgecombe@intel.com>
 <20190117154701.78aa8e9d0130716e0d9ac026@kernel.org>
 <F3B332DA-4637-4A3B-93F9-C7903C1D9FF9@zytor.com>
 <8817DE5F-BCF4-4F6A-A496-E0DB6889D86E@vmware.com>
 <F84CA28B-8BAA-468E-BA85-442E245871E5@zytor.com>
 <937f59ca-1d82-f5d9-4734-89680f23a661@zytor.com>
In-Reply-To: <937f59ca-1d82-f5d9-4734-89680f23a661@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6118;20:1Bkrr2Dm8nIv5iZ+sj8t9Ki12WLOadrMbCAPa9Ty0uvA+29jwpKSkJdB9nB43AwzfgSEwclt5FQw7a6IWmp74GUNi+oEM3dhfxsi7w0fbZBb9q3L0FyigVQrXMcd/ukgHJ398dqggVUyJRgOxBB7eHh96Ve8cckgIpcNXCttPVI=
x-ms-office365-filtering-correlation-id: eae3c84e-3352-403c-dd7a-08d67cee5d32
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6118;
x-ms-traffictypediagnostic: BYAPR05MB6118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB61180B5186F759705E35C22ED09C0@BYAPR05MB6118.namprd05.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(66066001)(99286004)(478600001)(83716004)(25786009)(14454004)(54906003)(316002)(2906002)(36756003)(71190400001)(4326008)(71200400001)(3846002)(6116002)(229853002)(86362001)(6486002)(6512007)(8936002)(5660300001)(53936002)(53546011)(6436002)(486006)(82746002)(6246003)(106356001)(93886005)(186003)(68736007)(6506007)(476003)(8676002)(14444005)(256004)(33656002)(2616005)(97736004)(26005)(76176011)(81166006)(11346002)(105586002)(102836004)(305945005)(7736002)(81156014)(6916009)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6118;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lzlvtiQykEJRiq85Jiclnuf8ddkmHQO+fK8FR7okb+2wjazs9LnJAnBHcaS1LJdq+//lMRburMipMcNdNdqFHoHirjJaFcoR32bzBPobx4VvL8A5kD3DcqwCqFxgIdJMuhCQlMcNT+bYD133UTgikVJ076uUb/+6Q68RuijTYrIXgwvBOe+7BJZ+MrFHj4Mg5gx+ClGlvdZbI+k4yqKxl4N0m2GXlfHDlUI9wCdn4frNPM9YbjT259PMLo5PJbDbgEvIRl+ajuJJRSXuoQkdfU2ItXOBYutUelRkiMy4GROEbxRc6n7WJdgpbq/TtkLF3Tmn0wT+KKsi/gZvCHTTxTRACSqDuZ5CV6+XDXwHWkW+zcjQyCdbK4/Zv0eeBZNRmjN2CNdzBmkNG3j9y6leAfkjdAYuXZkOj3DC95UXYfg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EB57C1483AE984AAF86012B9FB8614B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae3c84e-3352-403c-dd7a-08d67cee5d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 02:40:52.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6118
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiBPbiBKYW4gMTcsIDIwMTksIGF0IDM6MTkgUE0sIEguIFBldGVyIEFudmluIDxocGFAenl0b3Iu
Y29tPiB3cm90ZToNCj4gDQo+PiBJIHRoaW5rIHdlIGhhdmUgdGhyZWUgc3ViY2FzZXM6DQo+PiAN
Cj4+IDEuIEVhcmx5LCBVUCwgb3IgdW5kZXIgc3RvcF9tYWNoaW5lKCk7DQo+PiAyLiBBdG9taWMg
YW5kIGFsaWduZWQ7DQo+PiAzLiBCcmVha3BvaW50Lg0KPj4gDQo+PiBNeSBwcm9wb3NlZCBhbGdv
cml0aG0gc2hvdWxkIHJlbW92ZSB0aGUgbmVlZCBmb3IgYSBmaXh1cCB3aGljaCBzaG91bGQgaGVs
cCB0aGlzIGludGVyZmFjZSwgdG9vLg0KPj4gDQo+PiBUaGUgc3BlY2lmaWMgYWxpZ25tZW50IG5l
ZWRlZCBmb3IgIzIgaXMgc3RhcnRlZCBieSB0aGUgaGFyZHdhcmUgcGVvcGxlIHRvIGJlIG5vdCBj
cm9zc2luZyAxNiBieXRlcyAoTk9UIGEgY2FjaGUgbGluZSkgb24gYW55IENQVSB3ZSBzdXBwb3J0
IFNNUCBvbiBhbmQsIG9mIGNvdXJzZSwgYmVpbmcgcG9zc2libGUgdG8gZG8gYXRvbWljYWxseSBk
byBvbiB0aGUgc3BlY2lmaWMgQ1BVIChub3RlIHRoYXQgd2UgKmNhbiogZG8gYSByZWR1bmRhbnRs
eSBsYXJnZSBzdG9yZSBvZiBleGlzdGluZyBieXRlcywgd2hpY2ggYWRkcyBmbGV4aWJpbGl0eS4p
DQo+PiANCj4+IFRvIHRoZSBiZXN0IG9mIG15IGtub3dsZWRnZSBhbnkgQ1BVIHN1cHBvcnRpbmcg
U1NFIGNhbiBkbyBhbiBhdG9taWMgKGZvciBvdXIgcHVycG9zZXMpIGFsaWduZWQgMTYtYnl0ZSBz
dG9yZSB2aWEgTU9WQVBTOyBvZiBjb3Vyc2UgYW55IENQVSB3aXRoIGN4MTYgY2FuIGRvIGl0IHdp
dGhvdXQgU1NFIHJlZ2lzdGVycy4gRm9yIG9sZGVyIENQVXMgd2UgbWF5IGJlIGxpbWl0ZWQgdG8g
OC1ieXRlIHN0b3JlcyAoY3g4KSBvciBldmVuIDQtYnl0ZSBzdG9yZXMgYmVmb3JlIHdlIG5lZWQg
dG8gdXNlIHRoZSBicmVha3BvaW50IGFsZ29yaXRobS4NCj4gDQo+IFNlbmRpbmcgdG8gYSByZXN0
cmljdGVkIGxpc3QsIGJlY2F1c2UgSSBkb24ndCBhY3R1YWxseSBrbm93IGhvdyBwdWJsaWNseQ0K
PiBrbm93biB0aGlzIGlzLCBidXQgaXQgaXMga25vd24gdGhlcmUgYXJlIG9wZXJhdGluZyBzeXN0
ZW1zIGluIHRoZSBmaWVsZA0KPiBhbHJlYWR5IHdoaWNoIHJlbHkgb24gdGhlIDE2LWJ5dGUgYXRv
bWljaXR5IGd1YXJhbnRlZS4NCg0KSG1tLiAQSSBkb27igJl0IGtub3cgaG93IHJlc3RyaWN0ZWQg
dGhlIGxpc3QgaXMsIGNvbnNpZGVyaW5nIHlvdSBsZWZ0ICJMU00gbGlzdOKAnS4NCjstKQ0KDQpB
bnlob3csIEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgaXQgY2hhbmdlcyB0aGluZ3MgbXVjaC4gSWYg
eW91IHBhdGNoIGFuIE1NSU8NCmFjY2Vzc2luZyBpbnN0cnVjdGlvbiwgd2hpY2ggaXMgZXhlY3V0
ZWQgb24gdG9wIG9mIEtWTSAtIHRoaW5ncyBtaWdodCBicmVhay4NCklNSE8sIHRoZSB2ZXJ5IGxl
YXN0IGh5cGVydmlzb3JzIHZlbmRvcnMgc2hvdWxkIGJlIGluZm9ybWVkIGJlZm9yZQ0KaW1wbGVt
ZW50aW5nIHN1Y2ggY2hhbmdlLg0KDQo=
