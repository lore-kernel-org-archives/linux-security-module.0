Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E90C38A2A
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A173521775
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="vWFkcBJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEHR1S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 May 2020 13:27:18 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:14904 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgEHR1R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 13:27:17 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048HBKIk008156;
        Fri, 8 May 2020 13:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FFEe2BZLnoJvGRJJQIB2z6QeO3bQVS4Ef+oqYYjiyFw=;
 b=vWFkcBJ/IGhPk2VpM0nzDFxrU9Zs9g2Ozo6hZhGvJG8+N1gGB3mkw1iVz+kLtbuVwJS+
 1WrDxmMYxgd5MJcabOWhb4u5P0NzvQsy2j0AzGTZl7m+xDYd/rcYd9h42/LPF61jEd3G
 yqtb10HDBaQaknlGseoSi/sF6UvFVuoihftd+OPJgkqEJT+RGzDAYz+30YtydffTXi8j
 OTubn6g/jIAU8SoCaDqRAmJ3bQYSQBY9wBhMVdYEK2CiSklkgUu4l7sTqSJvxLBSELhJ
 /dW2DZCdYZOyLCzFayXBgeE3TeF8xatesrSuFBW2zjG/KrmJZOBy/x4eR/F6zR1pQEF3 LQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 30vthpagt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:27:16 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048HCuqG017862;
        Fri, 8 May 2020 13:27:15 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 30w8dmu88b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 13:27:15 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="499546708"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <hughsient@gmail.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Topic: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Index: AQHWI75rctPsm0zoq0Gk7Ve+Eu3BHaic5QmwgABnNoD//7UGAIAAXDCA//+v9jCAASH5AIAARIug
Date:   Fri, 8 May 2020 17:27:12 +0000
Message-ID: <34e4985da20747a780971b8ce7cd83ab@AUSX13MPC105.AMER.DELL.COM>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
 <20200508082028.GP487496@lahna.fi.intel.com>
In-Reply-To: <20200508082028.GP487496@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-08T17:27:10.3757819Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a95b4ddc-1c4c-4efa-aea1-28c03fa938ca;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.28]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_15:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080145
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080145
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwbGF0Zm9ybS1kcml2ZXIteDg2
LW93bmVyQHZnZXIua2VybmVsLm9yZyA8cGxhdGZvcm0tZHJpdmVyLXg4Ni0NCj4gb3duZXJAdmdl
ci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgTWlrYSBXZXN0ZXJiZXJnDQo+IFNlbnQ6IEZyaWRh
eSwgTWF5IDgsIDIwMjAgMzoyMCBBTQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvDQo+IENjOiBo
dWdoc2llbnRAZ21haWwuY29tOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IHNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gcGxhdGZvcm0veDg2OiBFeHBvcnQgTFBDIGF0dHJpYnV0ZXMgZm9yIHRoZSBzeXN0
ZW0NCj4gU1BJIGNoaXANCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBPbiBUaHUs
IE1heSAwNywgMjAyMCBhdCAwODowMzoyMVBNICswMDAwLCBNYXJpby5MaW1vbmNpZWxsb0BkZWxs
LmNvbQ0KPiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBG
cm9tOiBSaWNoYXJkIEh1Z2hlcyA8aHVnaHNpZW50QGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IFRo
dXJzZGF5LCBNYXkgNywgMjAyMCAyOjQ5IFBNDQo+ID4gPiBUbzogTGltb25jaWVsbG8sIE1hcmlv
DQo+ID4gPiBDYzogUGxhdGZvcm0gRHJpdmVyOyBsaW51eC1zZWN1cml0eS1tb2R1bGU7DQo+IG1p
a2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHBsYXRmb3JtL3g4NjogRXhwb3J0IExQQyBhdHRyaWJ1dGVzIGZvciB0aGUNCj4gc3lzdGVtIFNQ
SQ0KPiA+ID4gY2hpcA0KPiA+ID4NCj4gPiA+DQo+ID4gPiBbRVhURVJOQUwgRU1BSUxdDQo+ID4g
Pg0KPiA+ID4gT24gVGh1LCA3IE1heSAyMDIwIGF0IDIwOjIyLCA8TWFyaW8uTGltb25jaWVsbG9A
ZGVsbC5jb20+IHdyb3RlOg0KPiA+ID4gPiBCeSBkZWZhdWx0IHRoZSBkcml2ZXIgZXhwb3NlcyBT
UEkgc2VyaWFsIGZsYXNoIGNvbnRlbnRzIGFzIHJlYWQtDQo+IG9ubHkgYnV0IGl0DQo+ID4gPiBj
YW4NCj4gPiA+ID4gYmUgY2hhbmdlZCBmcm9tIGtlcm5lbCBjb21tYW5kIGxpbmUsIHBhc3Npbmcg
4oCcaW50ZWwtDQo+IHNwaS53cml0ZWFibGU9MeKAnS4NCj4gPiA+DQo+ID4gPiBBaGgsIHRoYXQg
d2FzIHRoZSBiaXQgSSBkaWRuJ3Qga25vdzsgaGF2aW5nIHRoZSBTUEkgYXMgcmVhZG9ubHkgYnkN
Cj4gPiA+IGRlZmF1bHQgaXMgY2VydGFpbmx5IGEgZ29vZCBpZGVhLCBhbmQgcHJvYmFibHkgc2Fu
ZSBlbm91Z2ggdG8gZW5hYmxlDQo+ID4gPiBmb3IgRmVkb3JhL1JIRUwgYXMgeW91IHN0aWxsIG5l
ZWQgdG8gImRvIiBzb21ldGhpbmcgbWFudWFsIHRvIGVuYWJsZQ0KPiA+ID4gU1BJIHdyaXRpbmcu
IEkgZ3Vlc3MgSSBjYW4gYWRkIG15IHNlY3VyaXR5ZnMgYWRkaXRpb25zIHRvDQo+ID4gPiBpbnRl
bC1zcGktcGNpLmMgd2l0aCBNaWthcyBhcHByb3ZhbC4NCj4gPiA+DQo+ID4gPiBSaWNoYXJkDQo+
ID4NCj4gPiBNaWthLA0KPiA+DQo+ID4gU2luY2UgeW91J3JlIGJlaW5nIGpvaW5lZCBpbnRvIHRo
ZSB0aHJlYWQgbGF0ZSwgaGVyZSBpcyB0aGUgY29udGV4dDoNCj4gPiBodHRwczovL3d3dy5zcGlu
aWNzLm5ldC9saXN0cy9wbGF0Zm9ybS1kcml2ZXIteDg2L21zZzIxNjQ2Lmh0bWwNCj4gDQo+IFRo
YW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uLiBJIGFjdHVhbGx5IHByZWZlciB0aGF0IHRoaXMgd291
bGQgYmUgaW4gYQ0KPiBzZXBhcmF0ZSBkcml2ZXIgYmVjYXVzZSBJIGRvIG5vdCB3YW50IGRpc3Ry
b3MgdG8gZW5hYmxlIGludGVsLXNwaSBqdXN0DQo+IGZvciB0aGlzLiBJdCBpcyByZWFsbHkgb25s
eSBtZWFudCBmb3Igc3BlY2lhbCBzZXR1cHMgd2hlcmUgZmlybXdhcmUNCj4gdXBncmFkZS9hY2Nl
c3MgZmxvdyBoYXMgYmVlbiB0aG9yb3VnaGx5IHRlc3RlZC4NCg0KTWlrYSwNCg0KVGhhbmtzIGZv
ciB0aG9zZSBjb21tZW50cyBhbmQgY29udGV4dCBvbiB0aGF0IGRyaXZlci4gIENvbnNpZGVyaW5n
IHRoaXMsDQp3aGF0IGRvIHlvdSB0aGluayBhYm91dCBhcyBwYXJ0IG9mIHRoaXMgbmV3IGRyaXZl
ciwgbW92aW5nIHRoZSBsaXN0IG9mDQpzdXBwb3J0ZWQgSURzIGluIHRoZXJlIHRvIHNvbWV0aGlu
ZyB0aGF0IGNhbiBiZSBzb3VyY2VkIGJ5IGJvdGggZHJpdmVycz8NCkkgdGhpbmsgaXQgc2hvdWxk
IGhlbHAgYXZvaWQgaGF2aW5nIHRvIGtlZXAgdGhlIHR3byBsaXN0cyBmdWxseSBpbiBzeW5jDQph
cyBuZXcgc2lsaWNvbiBjb21lcyBvdXQuDQoNClRoYW5rcywNCg==
