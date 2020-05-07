Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1CC38A2A
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 20:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A962208DB
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 20:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="WickvM+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgEGUDZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 16:03:25 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:25864 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbgEGUDY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 16:03:24 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047JvFlY010583;
        Thu, 7 May 2020 16:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=tEr4DTZK7SvXwly20dtlJ2PaDvIpy2M1pgck7taahaE=;
 b=WickvM+WDknQbbP9lYnFKJQkFMU0GD2aH2VQ1tEFPeuwVMVzDdNvvFrXGSKXY0oiEQuW
 DZmQ3whiobTHqai4KhbBDFoiE49Szo5cUmQ3Sf3YKU4B/Zguhu7dRKcCcltx52ty7kBk
 CRSaLshii2U+PliFBVg82O6N7f1UKrHSoPu9oEbQxJgZvbIHuOGNyb/6+4XTmJMYxPQV
 NyL72b7zUgX+QSPvsuQjAJyaN16cVJUc+GJ9eInHiSnGHbo2MHkW2SP+S4kilyeWsT6g
 Ag/9Ps5cELgGW8VicvQYHkS9aKNJ6j+ecJYAkwM+QjvJi+DiP6++u2wxfhEWi++kmyIY SA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 30t125wta6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 16:03:23 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Jrd44051488;
        Thu, 7 May 2020 16:03:22 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 30vnrr2t01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 16:03:22 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="546824532"
From:   <Mario.Limonciello@dell.com>
To:     <hughsient@gmail.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Topic: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Index: AQHWI75rctPsm0zoq0Gk7Ve+Eu3BHaic5QmwgABnNoD//7UGAIAAXDCA//+v9jA=
Date:   Thu, 7 May 2020 20:03:21 +0000
Message-ID: <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
In-Reply-To: <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-07T20:03:16.5475642Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=58512a44-be41-43ac-95e0-dc050676c476;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_13:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=884 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070159
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070159
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIEh1Z2hlcyA8aHVn
aHNpZW50QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSA3LCAyMDIwIDI6NDkgUE0N
Cj4gVG86IExpbW9uY2llbGxvLCBNYXJpbw0KPiBDYzogUGxhdGZvcm0gRHJpdmVyOyBsaW51eC1z
ZWN1cml0eS1tb2R1bGU7IG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gcGxhdGZvcm0veDg2OiBFeHBvcnQgTFBDIGF0dHJpYnV0ZXMgZm9yIHRo
ZSBzeXN0ZW0gU1BJDQo+IGNoaXANCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBP
biBUaHUsIDcgTWF5IDIwMjAgYXQgMjA6MjIsIDxNYXJpby5MaW1vbmNpZWxsb0BkZWxsLmNvbT4g
d3JvdGU6DQo+ID4gQnkgZGVmYXVsdCB0aGUgZHJpdmVyIGV4cG9zZXMgU1BJIHNlcmlhbCBmbGFz
aCBjb250ZW50cyBhcyByZWFkLW9ubHkgYnV0IGl0DQo+IGNhbg0KPiA+IGJlIGNoYW5nZWQgZnJv
bSBrZXJuZWwgY29tbWFuZCBsaW5lLCBwYXNzaW5nIOKAnGludGVsLXNwaS53cml0ZWFibGU9MeKA
nS4NCj4gDQo+IEFoaCwgdGhhdCB3YXMgdGhlIGJpdCBJIGRpZG4ndCBrbm93OyBoYXZpbmcgdGhl
IFNQSSBhcyByZWFkb25seSBieQ0KPiBkZWZhdWx0IGlzIGNlcnRhaW5seSBhIGdvb2QgaWRlYSwg
YW5kIHByb2JhYmx5IHNhbmUgZW5vdWdoIHRvIGVuYWJsZQ0KPiBmb3IgRmVkb3JhL1JIRUwgYXMg
eW91IHN0aWxsIG5lZWQgdG8gImRvIiBzb21ldGhpbmcgbWFudWFsIHRvIGVuYWJsZQ0KPiBTUEkg
d3JpdGluZy4gSSBndWVzcyBJIGNhbiBhZGQgbXkgc2VjdXJpdHlmcyBhZGRpdGlvbnMgdG8NCj4g
aW50ZWwtc3BpLXBjaS5jIHdpdGggTWlrYXMgYXBwcm92YWwuDQo+IA0KPiBSaWNoYXJkDQoNCk1p
a2EsDQoNClNpbmNlIHlvdSdyZSBiZWluZyBqb2luZWQgaW50byB0aGUgdGhyZWFkIGxhdGUsIGhl
cmUgaXMgdGhlIGNvbnRleHQ6DQpodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9wbGF0Zm9y
bS1kcml2ZXIteDg2L21zZzIxNjQ2Lmh0bWwNCg0KVGhhbmtzLA0K
