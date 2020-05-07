Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22ACC38A24
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AFA208E4
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 19:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="KwL6Xxhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEGTWI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 15:22:08 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:10448 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbgEGTWH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 15:22:07 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047JLx8x007505;
        Thu, 7 May 2020 15:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=IKb/k6K7+SS7J50jmI3MWADYrSwB7phKxZfApjJkk5c=;
 b=KwL6XxhzPVE92VYp0+QjmwkIzstB2awIJol6Pw3AiZt8lSgLnXjHxdGKYCvJ9sDq4xa7
 LZtvGG+uCJt3+a63tJbzAU74UWLDGYIKDqZl0Zv62s5H2ldG8G1EK6TlHEl3BrAFgF6g
 J4dpFdnQc4gVT6Yu0/LHaR3ytrtGRuVTsiaBhipgitgCO78bnzrw564PnmX6wDuGpKOI
 05VlEAGUOyM1y0uvIKwW9657IDqHdIw5MNq1G7y6iZZdqpaD6S9KwNaAs0MKBxrBx7eE
 /vKlKbWdKSG0nqU7tB+0oLWRM+sl2e1mq4Is+ohiNKvPP1Zyl+fh9DyivjJEzjA8ys0k zQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 30s4py7drk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 15:22:06 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047JIfk9089888;
        Thu, 7 May 2020 15:22:05 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 30vq4e9gyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 15:22:05 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="465832689"
From:   <Mario.Limonciello@dell.com>
To:     <hughsient@gmail.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Topic: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Index: AQHWI75rctPsm0zoq0Gk7Ve+Eu3BHaic5QmwgABnNoD//7UGAA==
Date:   Thu, 7 May 2020 19:22:02 +0000
Message-ID: <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
In-Reply-To: <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-07T19:22:00.4102069Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=301b3902-075c-4d55-a984-43bbedf0beb0;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_13:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=622 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=735 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070154
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwbGF0Zm9ybS1kcml2ZXIteDg2
LW93bmVyQHZnZXIua2VybmVsLm9yZyA8cGxhdGZvcm0tZHJpdmVyLXg4Ni0NCj4gb3duZXJAdmdl
ci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgUmljaGFyZCBIdWdoZXMNCj4gU2VudDogVGh1cnNk
YXksIE1heSA3LCAyMDIwIDE6NDcgUE0NCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbw0KPiBDYzog
UGxhdGZvcm0gRHJpdmVyOyBsaW51eC1zZWN1cml0eS1tb2R1bGUNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gcGxhdGZvcm0veDg2OiBFeHBvcnQgTFBDIGF0dHJpYnV0ZXMgZm9yIHRoZSBzeXN0ZW0g
U1BJDQo+IGNoaXANCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBPbiBUaHUsIDcg
TWF5IDIwMjAgYXQgMTg6NDUsIDxNYXJpby5MaW1vbmNpZWxsb0BkZWxsLmNvbT4gd3JvdGU6DQo+
ID4gVG8gZWNobyBBbmR5J3MgcXVlc3Rpb24sIEkgd291bGQgd29uZGVyIGlmIGl0IG1ha2VzIHNl
bnNlIHRvIGp1c3QgZXhwb3J0DQo+ID4gdGhlc2UgYXR0cmlidXRlcyBpbiBzZWN1cml0eWZzIGRp
cmVjdGx5IGZyb20gdGhlIGludGVsLXNwaS1wY2kgZHJpdmVyIHJhdGhlcg0KPiA+IHRoYW4gdG8g
aGF2ZSBhbm90aGVyIGRyaXZlciBpbiBwbGF0Zm9ybS14ODYgdG8gZ2V0IHRoZSBpbmZvcm1hdGlv
bi4NCj4gDQo+IFRoZSAiREFOR0VST1VTIiBpbiB0aGUgU1BJX0lOVEVMX1NQSV9QQ0kgYW5kIFNQ
SV9JTlRFTF9TUElfUExBVEZPUk0NCj4gd29ycmllZCBtZSBzb21ld2hhdC4gSSdtIGd1ZXNzaW5n
IHRoaXMgaXMgd2h5IG1vc3QgZGlzdHJvcyBkb24ndA0KPiBjb21waWxlIGl0IGFzIGEgbW9kdWxl
IGJ5IGRlZmF1bHQuIElmIHRoZSBtb2R1bGUgaXNuJ3QgYWN0dWFsbHkgc3RpbGwNCj4gY29uc2lk
ZXJlZCBkYW5nZXJvdXMsIGFuZCB3ZSBjYW4gcmVtb3ZlIHRoZSB3YXJuaW5nIEkgY2FuIG9mIGNv
dXJzZQ0KPiByZXNwaW4gbXkgcGF0Y2ggb24gdG9wIG9mIHRoYXQgaW5zdGVhZC4NCj4gDQo+IFJp
Y2hhcmQuDQoNCldlbGwgcmVhZGluZyB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgaXQgY2FuIGV4cGxh
aW4gd2h5IGl0J3MgcG90ZW50aWFsbHkgZGFuZ2Vyb3VzLg0KSWYgYSBtYW51ZmFjdHVyZXIgaGFz
bid0IHByb3Blcmx5IGNvbmZpZ3VyZWQgbG9jayBkb3duIGJpdHMgbGlrZSB0aG9zZSB5b3UncmUg
dHJ5aW5nDQp0byBleHBvc2UsIHRoYXQgd291bGQgYWxsb3cgZG9pbmcgZGFuZ2Vyb3VzIHRoaW5n
cy4NCg0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZHJpdmVyLWFwaS9t
dGQvaW50ZWwtc3BpLmh0bWwNCiINCiBUaGUgaW50ZWwtc3BpIGRyaXZlciBtYWtlcyBpdCBwb3Nz
aWJsZSB0byByZWFkIGFuZCB3cml0ZSB0aGUgU1BJIHNlcmlhbCBmbGFzaCwgaWYgDQpjZXJ0YWlu
IHByb3RlY3Rpb24gYml0cyBhcmUgbm90IHNldCBhbmQgbG9ja2VkLiBJZiBpdCBmaW5kcyBhbnkg
b2YgdGhlbSBzZXQsIHRoZSANCndob2xlIE1URCBkZXZpY2UgaXMgbWFkZSByZWFkLW9ubHkgdG8g
cHJldmVudCBwYXJ0aWFsIG92ZXJ3cml0ZXMuDQpCeSBkZWZhdWx0IHRoZSBkcml2ZXIgZXhwb3Nl
cyBTUEkgc2VyaWFsIGZsYXNoIGNvbnRlbnRzIGFzIHJlYWQtb25seSBidXQgaXQgY2FuDQpiZSBj
aGFuZ2VkIGZyb20ga2VybmVsIGNvbW1hbmQgbGluZSwgcGFzc2luZyDigJxpbnRlbC1zcGkud3Jp
dGVhYmxlPTHigJ0uDQoiDQo=
