Return-Path: <SRS0=9590=OA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273BFC32788
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 00:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA72214C1
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 00:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nccgroup.com header.i=@nccgroup.com header.b="Yv1Vpi3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA72214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=nccgroup.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeKULME (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:12:04 -0500
Received: from eu-smtp-delivery-170.mimecast.com ([146.101.78.170]:48401 "EHLO
        eu-smtp-delivery-170.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbeKULME (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 06:12:04 -0500
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 06:12:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nccgroup.com; s=mimecast20140812; t=1542760803; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=LJEK71UFnw0evEqoXrvlwsF2h5TnegYGXLCn4Hx/abc=; b=Yv1Vpi3ZzHJBRJqNKDROOS4Lmdd+eeKaoJZLZh3itChnh+thS15VKwlHDEvfjiYpLYQPtYJgYuN5PYrfdLsoKcW+W5NPnVq8WYJCu85xr+bllOTjS0OWT961cR5SXRR5OZadhS6VHUdRebEDRW8yhtFwupyVZqfkL3AZ1Zl11uI=
Received: from man1srvpgp01p.nccgroup.local (195.95.131.28 [195.95.131.28])
 (Using TLS) by relay.mimecast.com with ESMTP id
 uk-mta-129-QkAqxKIZM2uSZnIkehjFgA-1; Wed, 21 Nov 2018 00:33:31 +0000
X-MC-Unique: QkAqxKIZM2uSZnIkehjFgA-1
Received: from LDCDBSEXCH02p.nccgroup.local ([10.2.120.104])
  by man1srvpgp01p.nccgroup.local (PGP Universal service);
  Wed, 21 Nov 2018 00:33:31 +0000
X-PGP-Universal: processed;
        by man1srvpgp01p.nccgroup.local on Wed, 21 Nov 2018 00:33:31 +0000
Received: from LDCDBSEXCH01p.nccgroup.local (10.2.120.103) by
 LDCDBSEXCH02p.nccgroup.local (10.2.120.104) with Microsoft SMTP Server (TLS)
 id 15.0.1365.1; Wed, 21 Nov 2018 00:33:30 +0000
Received: from LDCDBSEXCH01p.nccgroup.local ([10.2.120.103]) by
 LDCDBSEXCH01p.nccgroup.local ([10.2.120.103]) with mapi id 15.00.1365.000;
 Wed, 21 Nov 2018 00:33:30 +0000
From:   Jeremy Boone <jeremy.boone@nccgroup.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "monty.wiseman@ge.com" <monty.wiseman@ge.com>,
        Monty Wiseman <montywiseman32@gmail.com>,
        "Matthew Garrett" <mjg59@google.com>
Subject: Re: EXTERNAL: Re: Documenting the proposal for TPM 2.0 security in
 the face of bus interposer attacks
Thread-Topic: EXTERNAL: Re: Documenting the proposal for TPM 2.0 security in
 the face of bus interposer attacks
Thread-Index: AQHUgMG6fMVG3SmrKkORwyZOIKK+qqVYmyQAgABPeYCAAGEgAIAADLeAgAAJq4A=
Date:   Wed, 21 Nov 2018 00:33:29 +0000
Message-ID: <B36B1B49-14E8-4489-AA9F-4A2AFD816B03@nccgroup.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181120111049.GC14594@linux.intel.com>
 <20181120124116.GA8813@linux.intel.com>
 <1542734743.2814.31.camel@HansenPartnership.com>
 <20181120231320.GI8391@linux.intel.com>
 <1542758331.2814.48.camel@HansenPartnership.com>
In-Reply-To: <1542758331.2814.48.camel@HansenPartnership.com>
Accept-Language: en-CA, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
smime:  TRUE
MIME-Version: 1.0
Content-Language: en-CA
Content-Type: multipart/signed;
        boundary="Apple-Mail-DA873B64-F5BF-4A96-919C-ED5203FBF774";
        protocol="application/pkcs7-signature"; micalg=sha1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Apple-Mail-DA873B64-F5BF-4A96-919C-ED5203FBF774
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: base64

DQoNCj4gT24gTm92IDIwLCAyMDE4LCBhdCA2OjU4IFBNLCBKYW1lcyBCb3R0b21sZXkgPEphbWVz
LkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+IHdyb3RlOg0KPiANCj4+IE9uIFdlZCwg
MjAxOC0xMS0yMSBhdCAwMToxMyArMDIwMCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0KPj4+IE9u
IFR1ZSwgTm92IDIwLCAyMDE4IGF0IDA5OjI1OjQzQU0gLTA4MDAsIEphbWVzIEJvdHRvbWxleSB3
cm90ZToNCj4+Pj4gT24gVHVlLCAyMDE4LTExLTIwIGF0IDE0OjQxICswMjAwLCBKYXJra28gU2Fr
a2luZW4gd3JvdGU6DQo+Pj4+PiBPbiBUdWUsIE5vdiAyMCwgMjAxOCBhdCAwMToxMDo0OVBNICsw
MjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+Pj4+PiBUaGlzIGlzIGJhc2ljYWxseSByZXdy
aXRlIG9mIFRQTSBnZW5pZSBwYXBlciB3aXRoIGV4dHJhcy4gTWF5YmUNCj4+Pj4+IGp1c3Qgc2hv
cnRlbiBpdCB0byBpbmNsdWRlIHRoZSBwcm9wb3NlZCBhcmNoaXRlY3R1cmUgYW5kIHBvaW50DQo+
Pj4+PiB0byB0aGUgVFBNIEdlbmllIHBhcGVyICh3aGljaCBpcyBub3QgaW4gdGhlIHJlZmVyZW5j
ZXMgYXQgYWxsDQo+Pj4+PiBBVE0pLg0KPj4+Pj4gDQo+Pj4+PiBUaGUgd2F5IEkgc2VlIGl0IHRo
ZSBkYXRhIHZhbGlkYXRpb24gaXMgd2F5IG1vcmUgaW1wb3J0YW50IHRoYW4NCj4+Pj4+IHByb3Rl
Y3RpbmcgYWdhaW5zdCBwaHlzaWNhbCBpbnRlcnBvc2VyIHRvIGJlIGZyYW5rLg0KPj4+Pj4gDQo+
Pj4+PiBUaGUgYXR0YWNrIHNjZW5hcmlvIHdvdWxkIHJlcXVpcmUgdG8gb3BlbiB0aGUgZGFtbiBk
ZXZpY2UuIEZvcg0KPj4+Pj4gbGFwdG9wIHRoYXQgd291bGQgbGVhdmUgcGh5c2ljYWwgbWFya3Mg
KGkuZS4gZXZpbCBtYWlkKS4gSW4gYQ0KPj4+Pj4gZGF0YSBjZW50ZXIgd2l0aCBhcm1lZCBndWFy
ZHMgSSB3b3VsZCB3aXNoIHlvdSBnb29kIGx1Y2sNCj4+Pj4+IGFjY29tcGxpc2hpbmcgaXQuIEl0
IGlzIG5vdCBhbnl0aGluZyBsaWtlIHN0aWNraW5nIGEgVVNCIHN0aWNrDQo+Pj4+PiBhbmQgcnVu
Lg0KPj4+Pj4gDQo+Pj4+PiBXZSBjYW4gdGFrZSBhIGZpeCBpbnRvIExpbnV4IHdpdGggYSBjbGVh
biBpbXBsZW1lbnRhdGlvbiBidXQgaXQNCj4+Pj4+IG5lZWRzIHRvIGJlIGFuIG9wdC1pbiBmZWF0
dXJlIGJlY2F1c2Ugbm90IGFsbCB1c2VycyB3aWxsIHdhbnQNCj4+Pj4+IHRvIHVzZSBpdC4NCj4+
Pj4gDQo+Pj4+IFNvbWVvbmUgKG1pZ2h0IGhhdmUgYmVlbiBlaXRoZXIgTWltaSBvciBEYXZpZCBI
b3dlbGxzIGJ1dCBjYW5ub3QNCj4+Pj4gcmVjYWxsKSBjb3JyZWN0bHkgcG9pbnRlZCBvdXQgYXQg
TFNTIDIwMTggdGhhdCB5b3UgY291bGQganVzdCBhcw0KPj4+PiBlYXNpbHkgc3B5IGFuZCBjb3Jy
dXB0IFJBTSBpZiB5b3UgaGF2ZSBhIHRpbWUgd2luZG93IHRvIHBlcmZvcm0NCj4+Pj4gdGhpcyB0
eXBlIG9mIGF0dGFjay4NCj4+PiANCj4+PiBOb3QgdXNpbmcgdGhlIHNpbXBsZSBwbHVnIGluIG9u
IHRoZSBUUE0gYnVzLCB5b3UgY2FuJ3QuICBUaGUgcG9pbnQNCj4+PiBpcyBiYXNpY2FsbHkgdGhl
IGRpZmZlcmVuY2UgaW4gdGhlIHRlY2hub2xvZ3k6IHRoZSBpbnRlcnBvc2VyIGlzIGENCj4+PiBz
aW1wbGUsIGVhc3kgdG8gY29uc3RydWN0LCBwbHVnaW47IGEgUkFNIHNweSBpcyBhIGh1Z2UgSlRB
RyB0aGluZw0KPj4+IHRoYXQgd291bGQgYmUgaGFyZCBldmVuIHRvIGZpdCBpbnRvIGEgbW9kZXJu
IHRoaW4gbGFwdG9wLCBsZXQgYWxvbmUNCj4+PiBleHRyZW1lbHkgZGlmZmljdWx0IHRvIGJ1aWxk
Lg0KPj4gDQo+PiBXaHkgeW91IHdvdWxkbid0IHVzZSBETUEgdG8gc3B5IHRoZSBSQU0/DQo+IA0K
PiBZb3UgbWVhbiBmcm9tIGEgcGx1Z2luIG9uIHRoZSBUUE0gYnVzPyBtb3N0IG9mIHRoZSBidXNl
cyB0aGUgVFBNIGlzIG9uDQo+IGRvbid0IGdldCBETUEgYWNjZXNzLiAgU29tZSBvZiB0aGVtIGJh
cmVseSBnZXQgaW50ZXJydXB0cywgd2hpY2ggaXMgd2h5DQo+IHdlIHdhc3RlIGEgbG90IG9mIHRp
bWUgcG9sbGluZyBpbiBUUE0gZHJpdmVycy4NCg0KWW91IGNhbiBkbyBETUEgb3ZlciB0aGUgTFBD
IGJ1cyBpZiB5b3UgcHVsbCBkb3duIHRoZSBMRFJRIHBpbi4gQnV0IHR5cGljYWxseSB0aGF0IHBp
biBpc27igJl0IHBvcHVsYXRlZCBvbiB0aGUgVFBNIGhlYWRlciBvbiBtYWluYm9hcmRzLiBJIHN1
cHBvc2UgdGhpcyBtYXkgYmUgaW50ZW50aW9uYWwuIA0KDQo+IA0KPiBKYW1lcw0KPiANCg==

--Apple-Mail-DA873B64-F5BF-4A96-919C-ED5203FBF774
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGODCCBjQw
ggUcoAMCAQICEAEJ+XaUirTKFDXrmkF/knMwDQYJKoZIhvcNAQENBQAwZTELMAkGA1UEBhMCVVMx
FTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIGA1UE
AxMbRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIENBMB4XDTE4MDkwNzAwMDAwMFoXDTIxMDkwNzEy
MDAwMFowUTELMAkGA1UEBhMCR0IxEzARBgNVBAcTCk1hbmNoZXN0ZXIxFjAUBgNVBAoTDU5DQyBH
cm91cCBQTEMxFTATBgNVBAMTDEplcmVteSBCb29uZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCC
AgoCggIBANIMHGOcKFG2g8urbwLGZcpE8X6szEZXdXwA+i16JKsQrMJd8kHZ2EC1Gs+FPhXV/jzu
2Pb7Z21q0ZIMa5PdpC8JCVKk5T2lSykMndnUVv30s0hQJPNXWvdO93xopWnOdM+bKEz+pYNoYaSZ
ukHAKlkPTeDfEUdP2J0/s5NDeCUZycLNhmHXvkMS07B4m7t0dQCbzQfMx+uceEZ+HsuhicOwbh79
11a/iC9UOyA+dSIl8Hyl2sriNr2Nba61YLRdEUrV32OwiYUedIr1MtQRc9oINwtCXCbqDRcdaJ01
n5TSBIX42zyJcPWGzz9A9ocKqotDp84smw+dktmg0pBPoc4lrJ/wAW2ouqfeBx+LIGFIM/JSfitX
HaZeY3m2vlExHDRQjU38K4i22E8iltQ4YsGTT4XVEH80LIDQiy9xXzN5WH4re81aebSaJP0pg5qM
kULoFi3a6QASOpils1E+TvwkygLDSXRGiO/7eUEJ96CPWMxeaRsuPv4yHO5AWyPiVnOxfv/kJVHq
r2z6a9yVHRzhRtseQBTAlNiMuADiDMvsixD8F72gYguUlib37Ar3ARrovHiE5h64pZoa3GbY7rjg
ic9uddHyf9dt7WrRXuLXCR3RxxZqqvyoTY0tb1QncNmKQo6P0JD3WrjSSoMpEYhxSlUy5WgoblRD
Sfz3E5YLAgMBAAGjggHyMIIB7jAfBgNVHSMEGDAWgBTnAiOAAE/Y17yUC9k/dDlJMjyKeTAdBgNV
HQ4EFgQUb/31vCdNPMbdI8MKWjcnKHWIPDUwDAYDVR0TAQH/BAIwADAkBgNVHREEHTAbgRlqZXJl
bXkuYm9vbmVAbmNjZ3JvdXAuY29tMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwQwYDVR0gBDwwOjA4BgpghkgBhv1sBAECMCowKAYIKwYBBQUHAgEWHGh0dHBz
Oi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYgGA1UdHwSBgDB+MD2gO6A5hjdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNzdXJlZElEQ0EtZzIuY3JsMD2gO6A5hjdodHRwOi8v
Y3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNzdXJlZElEQ0EtZzIuY3JsMHkGCCsGAQUF
BwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAC
hjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNzdXJlZElEQ0EuY3J0
MA0GCSqGSIb3DQEBDQUAA4IBAQDJxuvlSYH3naQXpVjpc2uDNF8K+wGzC7ESkhumFR2Bf6B8ysaR
6vRNGuIvawBXsXxBCfpbGvA1PLf7DtmxaMRp5XqV58n8YKEVtVtkJZXF3U2bqdH9hqeNoBDO5cfc
6zgZafOfBczyafLQcDRNUmu8nhuJQFIre4OpeYwjVf0nSfgjsx/i4fzfhvpldldJmryjGaUW/tbm
B7JowoLm9V6H2yuuOKZrnRofmfz7m8MzAAT5JgXCqKi+Yfq4vBrkyb0NGmXiSGqK6PdH3Jz1Mb8z
WUt3UAl/SOXV9OZujodKeoAqk2IFoPFlKexKrPjMC4FN0eSRobHeLR5xsR3RT7v+MYIEGTCCBBUC
AQEweTBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
ZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ0ECEAEJ+XaU
irTKFDXrmkF/knMwCQYFKw4DAhoFAKCCAXUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTgxMTIxMDAzMzI3WjAjBgkqhkiG9w0BCQQxFgQU4SKiVGWL34xZjd9KFb4J
B47KvfwwgYgGCSsGAQQBgjcQBDF7MHkwZTELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0
IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIGA1UEAxMbRGlnaUNlcnQgU0hBMiBB
c3N1cmVkIElEIENBAhABCfl2lIq0yhQ165pBf5JzMIGKBgsqhkiG9w0BCRACCzF7oHkwZTELMAkG
A1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNv
bTEkMCIGA1UEAxMbRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIENBAhABCfl2lIq0yhQ165pBf5Jz
MA0GCSqGSIb3DQEBAQUABIICAHViXezKKCx1sa5vPtdSieLgyMYD/nibsnWKl4v5OOK6ipuJLWkR
miAEimweKbB5eCicJ1JpVLwzSkhVLRZznaKH7jBuLb2WU5y/cGJlgq9To/ePPT6xjs95D9rCpVzW
kLVC2PK6LpQ44Bbo9jnX0FpWYYMvog6y9EURNXDc5K7JZ/s2ycolwIuXFtea36hs1p1vzx4lb19W
YvR96SzdmpwcbPsCXHGIEYsurPVCshsJWaxuwRbBPNZx3PxBdr+K2Y4FyEgN5/pDKdbgeAQipNYU
2lAxtDK9MJMVV6zaaMRCW7X/wzrHG7TCVulARcoVMHD0Jdz+9zmPmrtcRsQG/fDuHwGacYVEUJoW
JRghOkLNJDCNRyoltVcFmucXbt05zlP0x8Rrw5e2JdT9I1kL55Y/+rFPPHGIhwfCjHQIHDul95qE
O8DQEZzNoriVnxpRWkZ5Gn2E8nwYT7k4SdkPHabnMDIipg1mZyhI6xq1dcEzWRe+2xRCn4vIECWK
bOp3scaBiPQj/vQ/PfiyVejcGm3+nrGe4X7r/LdthLcOka7WopoYYbBGQYPnJJisolR5joL2eefY
Ptw3kGoaHgpwTcBLkJMCVImbhhUC/gEUHVzv2thXWxmoqWDfH3j8Fi540ilyx2d216YNLOpXS7fv
Hwz5pvVKdia6s4BGHuzMd9kHAAAAAAAA

--Apple-Mail-DA873B64-F5BF-4A96-919C-ED5203FBF774--

