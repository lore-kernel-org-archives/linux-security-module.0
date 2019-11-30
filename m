Return-Path: <SRS0=VGHz=ZW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFAC432C0
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Nov 2019 06:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8540A2075C
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Nov 2019 06:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0t6G04/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfK3GuZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:50:25 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40564 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfK3GuZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 30 Nov 2019 01:50:25 -0500
Received: by mail-yb1-f193.google.com with SMTP id n3so8687354ybm.7
        for <linux-security-module@vger.kernel.org>; Fri, 29 Nov 2019 22:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:autocrypt:message-id:date:mime-version;
        bh=qLdH4rIk8dPChodvxqZluSfbkLcyDjrJYbrdfOciYfo=;
        b=K0t6G04/G6tMio0vJuMenvZlM8fpsBGkD3I830n0U56djmW7CMJRcZdIkdyWa0aTvB
         3K53zDpHsVtZb24myVkvjq+Y7JUwTZNqkRxFtWnGxxYZO9wkRb7889lzCHWP3RScRP7j
         xz4FqR6Apj1wsDpjSjwNcT84Uk/CX5loH5MB+T4fKlmZisO0t7m2K1t6BgjeXUEeVccB
         WwNm7SQ7u4UyS5b7rbVgIPlJfmtOEJz++ZqC7hFm5OVOnFD5VqeOcvtv1kYA9GfWJN9x
         cep+2+oeTgwWTP1j2e0P8jB5vJSdIkpJ67RSuB6e5m1aM388Obht8BZn0bQ5geZozeMt
         mOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:autocrypt:message-id:date
         :mime-version;
        bh=qLdH4rIk8dPChodvxqZluSfbkLcyDjrJYbrdfOciYfo=;
        b=ETSRUYjOD2Ra5viEAgBec/g39X53sJoiY4JCFh2Qa8y8jxnFVJvXjgHDzocWrlAinO
         PEh3n0MrLd3nSJq0Ld1m/Z9evwxIvFhvgoL/M3nNcx7+6yAgv/ZN51buWC419gpmgF/p
         AnAvXmQPUCvVizDZEmKDpKuuLqNKhRe6JMyOcBWQIJGHM0Jr6QoDREBz0z9nwd3q4Lc8
         2gHZ4vVC/rfFeK3KUoP9EtDRTMdgJjFkFrRk8t2Q4UrjnywGQoL8fe0UzWvCiknKiGoY
         80qixLYNIe5YE9gX1EBA81wMiaC58rwpgHt5wJXTcex4BNibS1+fR5r2izb0sn3iV82y
         Ggzw==
X-Gm-Message-State: APjAAAX21EqcBb4q7WNTMUfkZ/gY2uTCzStnKTGvuFxyLjvEWBXDiumz
        EWhiMLjyDmshZCGIml9nsVg=
X-Google-Smtp-Source: APXvYqypjqgP5GPVEWtbnmCvT+AvqbwcKapZP4NahX0Cte0Gl+B5FxTVzszG/0EFQBPksxLDVfwF3A==
X-Received: by 2002:a25:7ec1:: with SMTP id z184mr39671583ybc.62.1575096624299;
        Fri, 29 Nov 2019 22:50:24 -0800 (PST)
Received: from [192.168.2.191] (173-17-41-233.client.mchsi.com. [173.17.41.233])
        by smtp.gmail.com with ESMTPSA id 17sm11102419ywb.13.2019.11.29.22.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 22:50:23 -0800 (PST)
To:     linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, matthew.garrett@nebula.com,
        keescook@chromium.org
From:   Matt Parnell <mparnell@gmail.com>
Subject: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access even,
 in confidentiality mode.
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFo3GdQBEADtjJfHcx+4ZWkygvBe298oW4OwHbF0iLJd/+yOObV/2/F2hHNvIsnY0syy
 ew0pdCBGbzhUlQbzIGEI1aBiikFP/g7zbWGf2r1Gkye+vka252dPZbeCW+reSbMQ6wsSpaLN
 tKvhwq7gIRQjMrSIXtLF/idxMzcd6R0r+DD2cojhktj/qsfhGArigjsuCedX5xFHHjM368Du
 o8FhTteNZePd8VoA7INrDmSUtEp1OOP98UCCr1bIO1K1AvMxHfAhqhEELXDZDgp3UgaIn24q
 SxqNDfNExSnqjMUPafGW3Gxq8hez5hmTrvml14v8VT3B/TIbqzOOH0CWxwTNUkq3gOjrZWcZ
 X4giVsBhZtFckr1KIMOl0IbL9N1El20LxPiqqQDrg633s4+22pKDq9c9JLuNSCHpXVaIaDS4
 mY36SWCXNkO1QZn1NrIjctTjqmSzqH2w7borNUbtQLnnCo9SBXnCP9tO7pM4SI8dN0ehE9tP
 mQjNyPQjCCCaVMCAx69qTSKhIHQ9flnDbW+NNY3rFdN/IlpEqmZaFC21b+xRwEYys9MOdumR
 WVv4+mjMUkoyNRwtMg1W6WUhcQ0VczmTiczgztjTAJy3NjVfklIT1t6jM8n2yJOoUzLmp7DP
 4dJmHpmUa73ITH6FtbOqE2AhOMFlXDxsNvPE8ukiWotP+m+xSwARAQABtCFNYXR0IFBhcm5l
 bGwgPG1wYXJuZWxsQGdtYWlsLmNvbT6JAlQEEwEIAD4WIQTLFpSDKxWZjIp7E2+53Q5PJNJa
 oAUCWjcZ1AIbIwUJCWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRC53Q5PJNJaoJaa
 EACoF+DCyEZAkDAa+E+Mj0molEY41CmRmJGzsMd+Uhh7ZdLc65FqxDyN59w4DOEcFVUef95F
 YAjyhDrvf17EUS12R1TZ5h31akBsAKk0KR81W0ZCvI6/iS1ChZ0+wG+GedNxwp3YY+8gvnix
 B6/W3kmgHqBJAHGtlEjzGhkoHzsyc/+f0IsCd3G/bB6ZJLOQbqCKPS8YtaSflWt9SlPsHB9D
 +JjbsNT7Kn05ygeeF2J25L/q+Dwy9W0p2TByb2HAZpma2U4MIUUdCtrEQ7xMQ79xFqakBuKT
 f3dp2RJYXTeRkbFrsuycX60hH9flJZPZ6Q5wGCWzhiApjYy+mhnCzvrAuyvuuozvLxJ0M6Wk
 zCMMFFVnQNypYZTUYwXICb2oo4HcN50U5ZkzzWAjCLJg90ZioD/7fCO7rOs301GsB6rV94ah
 ktt+ma7a+hu25EZinAiTGFDk3n2G40rtELkphH+GIZYCrKrGcnEhicuGEAzi5+TewWnfLVTm
 wRVfXPMMcKFTV6XEUjWYGtgG4yxAjjBFqIY0XtT1GzpVVNzg90SW3ABD9dTSfsqk2MugrgPa
 /zELohio/V/O7Zm26BnhPi5sfK3T0AeDLqHwJrup5Osd2tf5zx3b3uFCRd1Jf8uoAZIBmKmH
 oios8sXRXOKy3dJEvtyeRZ9ai6lsNwaid2+zoLkCDQRaNxnUARAAu0Vk93D3ETcFVtb3uszZ
 K2Rzd6Wa3PJDnQ0PC4ER0ZK8QZg6I0rFlsxYWf8d9SghI5aXxtqcsyTiVoIPhCtH3KXt7nDU
 bsOlwP43KTX4VhlT4ocGpJb0DvfryjD3HD68IOeyvrsPWgf64Vk0CWYFSGYfBIC8ydew4YOT
 g6n/h/qrNhSMZTTJwNmXaHxPQy6OeMggu/5ZMylJTZ6Rs8inKLDs1/Wa584coH9npX2xsl9o
 GyBv2cIzz9fNmpLuRc+QWFeFtFuiZhd09GIEtbwH+qzo+8wq7lJxedEiePXYa4KfKigGmfTk
 D1W+WTGvF1Ui1uIljDZCRhMZlfIFcmwSeNLMjexaQboQnfS+qgnrwNkvN80azJd0wUcmsTAm
 A5ES4QleM0U1b/0YcoGni0ES1FgebLbptj8R1eem5ZTXJ4pxm5IZCmaYgv2rJwTl4dDYxUVO
 A8ATQUQ4tPPclk8FECfG1k/fGLpyku2n3rUFMTv4JGCZvHrTuy4BPQAwztVAxPw3Qx85TlwI
 5U9npigZa3tNuXrvOXfJzwZZaedCFf2JjJYBpWEYDDqdUXdj38hpOeZszwgRyWCqrxUSi1O6
 DoChrBlM2ETBQ9WG38TDQ1CyAXI8ctm8anUfVgVyDbbUTaHw61S+Nn4w9fj1sA4+q9hSsIlM
 xTXxMgpAfPwQ7kUAEQEAAYkCPAQYAQgAJhYhBMsWlIMrFZmMinsTb7ndDk8k0lqgBQJaNxnU
 AhsMBQkJZgGAAAoJELndDk8k0lqgcMoP/iaPjCViJAoae8/x8IGykah8l7QYjJWraxKuNI4C
 wYL9Hmm4pr6C3vtckOKs678QdB3Js6sfuD6eCQowTLQEBrP7LJU0Cw0S4x0oaSw7i1aySTIa
 QuPc5gjuqmZa7NeP0/sY/Is43b2mePf5ETTbcJM3PA44xkjQ21qR05pbF5ISlDqKvDog60dE
 /dDAnlFkP7H8PPmuXnqcaW1isPoBIZOsNY1Lt91rogTgvKXiIvz+ze2VYuBaEpyqJfchkwfR
 oUEQGljjXn5E98KfCDqou0gcP14BKBP45XhlD121PyoNgs/zCWpeAkrerctpl579hVrfg2yT
 gMsRsE9dlOdBsB1RAhB0Tmtqn75uBCKU3SCBgP/GZ0ZvoBiF+YQk/a5BFjQK1BsEdtXkwJxY
 mCGMPE3C0ADjxKUTx7wnmineBjc9B3yDugN7efpwHfltM6kKkbHNGoUz95Nhdp00GMYiwpcW
 EGbY1YzYACwMFwyWLaO8wWVo5MDe28OLpKbjHz3Zlu7E4gIJx3jId4coWSV7X1oAnq0JGUSO
 ypEChR786n/GobJlYw5UDWUJsmOFB9IXzt7o3YyKibpjPMmQY4tPUc137cJrbjsXU22fYrZn
 BPsD42iWdKVVoEd04MIj6OvIZCNHBRZA8Bly8xKPSLJIWNG0YZ7ETA0070lPmh9s3xqW
Message-ID: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
Date:   Sat, 30 Nov 2019 00:49:48 -0600
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kDw9EFYc3MFHsaWt0EszyYW1nbEIy8d52"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kDw9EFYc3MFHsaWt0EszyYW1nbEIy8d52
Content-Type: multipart/mixed; boundary="tExhhjTeEMx2YhVb9V99CZxVYOnvqHjZH"

--tExhhjTeEMx2YhVb9V99CZxVYOnvqHjZH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US

RnJvbSA0NTJiODQ2MGU0NjQ0MjJkMjY4NjU5YThhYmI5MzM1M2ExODJmOGM4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0IFBhcm5lbGwgPG1wYXJuZWxsQGdtYWlsLmNv
bT4KRGF0ZTogU2F0LCAzMCBOb3YgMjAxOSAwMDo0NDowOSAtMDYwMApTdWJqZWN0OiBbUEFU
Q0hdIEtlcm5lbCBMb2NrZG93bjogQWRkIGFuIG9wdGlvbiB0byBhbGxvdyByYXcgTVNSIGFj
Y2VzcyBldmVuCsKgaW4gY29uZmlkZW50aWFsaXR5IG1vZGUuCgpGb3IgSW50ZWwgQ1BVcywg
c29tZSBvZiB0aGUgTURTIG1pdGlnYXRpb25zIHV0aWxpemUgdGhlIG5ldyAiZmx1c2giIE1T
UiwgYW5kCndoaWxlIHRoaXMgaXNuJ3Qgc29tZXRoaW5nIG5vcm1hbGx5IHVzZWQgaW4gdXNl
cnNwYWNlLCBpdCBkb2VzIGNhdXNlIGZhbHNlCnBvc2l0aXZlcyBmb3IgdGhlICJGb3JzaGFk
b3ciIHZ1bG5lcmFiaWxpdHkuCgpBZGRpdGlvbmFsbHksIEludGVsIENQVXMgdXNlIE1TUnMg
Zm9yIHZvbHRhZ2UgYW5kIGZyZXF1ZW5jeSBjb250cm9scywKd2hpY2ggaW4KbWFueSBjYXNl
cyBpcyB1c2VmdWwgZm9yIHVuZGVydm9sdGluZyB0byBhdm9pZCBleGNlc3MgaGVhdC4KClNp
Z25lZC1vZmYtYnk6IE1hdHQgUGFybmVsbCA8bXBhcm5lbGxAZ21haWwuY29tPgotLS0KwqBh
cmNoL3g4Ni9rZXJuZWwvbXNyLmPCoMKgwqDCoCB8wqAgNSArKysrLQrCoHNlY3VyaXR5L2xv
Y2tkb3duL0tjb25maWcgfCAxMiArKysrKysrKysrKysKwqAyIGZpbGVzIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvbXNyLmMgYi9hcmNoL3g4Ni9rZXJuZWwvbXNyLmMKaW5kZXggMTU0N2JlMzU5ZDdm
Li40YWRjZTU5NDU1YzMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9tc3IuYworKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvbXNyLmMKQEAgLTgwLDEwICs4MCwxMSBAQCBzdGF0aWMgc3Np
emVfdCBtc3Jfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0CmNoYXIgX191c2VyICpi
dWYsCsKgwqDCoMKgIGludCBlcnIgPSAwOwrCoMKgwqDCoCBzc2l6ZV90IGJ5dGVzID0gMDsK
wqAKKyNpZiBkZWZpbmVkKExPQ0tfRE9XTl9ERU5ZX1JBV19NU1IpCsKgwqDCoMKgIGVyciA9
IHNlY3VyaXR5X2xvY2tlZF9kb3duKExPQ0tET1dOX01TUik7CsKgwqDCoMKgIGlmIChlcnIp
CsKgwqDCoMKgIMKgwqDCoCByZXR1cm4gZXJyOwotCisjZW5kaWYKwqDCoMKgwqAgaWYgKGNv
dW50ICUgOCkKwqDCoMKgwqAgwqDCoMKgIHJldHVybiAtRUlOVkFMO8KgwqDCoCAvKiBJbnZh
bGlkIGNodW5rIHNpemUgKi8KwqAKQEAgLTEzNSw5ICsxMzYsMTEgQEAgc3RhdGljIGxvbmcg
bXNyX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZAppbnQgaW9jLCB1bnNpZ25l
ZCBsb25nIGFyZykKwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBlcnIgPSAtRUZBVUxUOwrCoMKg
wqDCoCDCoMKgwqAgwqDCoMKgIGJyZWFrOwrCoMKgwqDCoCDCoMKgwqAgfQorI2lmIGRlZmlu
ZWQoTE9DS19ET1dOX0RFTllfUkFXX01TUikKwqDCoMKgwqAgwqDCoMKgIGVyciA9IHNlY3Vy
aXR5X2xvY2tlZF9kb3duKExPQ0tET1dOX01TUik7CsKgwqDCoMKgIMKgwqDCoCBpZiAoZXJy
KQrCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGJyZWFrOworI2VuZGlmCsKgwqDCoMKgIMKgwqDC
oCBlcnIgPSB3cm1zcl9zYWZlX3JlZ3Nfb25fY3B1KGNwdSwgcmVncyk7CsKgwqDCoMKgIMKg
wqDCoCBpZiAoZXJyKQrCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGJyZWFrOwpkaWZmIC0tZ2l0
IGEvc2VjdXJpdHkvbG9ja2Rvd24vS2NvbmZpZyBiL3NlY3VyaXR5L2xvY2tkb3duL0tjb25m
aWcKaW5kZXggZTg0ZGRmNDg0MDEwLi5mNGZlNzJjNGJmOGYgMTAwNjQ0Ci0tLSBhL3NlY3Vy
aXR5L2xvY2tkb3duL0tjb25maWcKKysrIGIvc2VjdXJpdHkvbG9ja2Rvd24vS2NvbmZpZwpA
QCAtNDQsNCArNDQsMTYgQEAgY29uZmlnIExPQ0tfRE9XTl9LRVJORUxfRk9SQ0VfQ09ORklE
RU5USUFMSVRZCsKgwqDCoMKgIMKgY29kZSB0byByZWFkIGNvbmZpZGVudGlhbCBtYXRlcmlh
bCBoZWxkIGluc2lkZSB0aGUga2VybmVsIGFyZQrCoMKgwqDCoCDCoGRpc2FibGVkLgrCoAor
Y29uZmlnIExPQ0tfRE9XTl9ERU5ZX1JBV19NU1IKK8KgwqDCoCBib29sICJMb2NrIGRvd24g
YW5kIGRlbnkgcmF3IE1TUiBhY2Nlc3MiCivCoMKgwqAgZGVwZW5kcyBvbiBMT0NLX0RPV05f
S0VSTkVMX0ZPUkNFX0NPTkZJREVOVElBTElUWQorwqDCoMKgIGRlZmF1bHQgeQorwqDCoMKg
IGhlbHAKK8KgwqDCoCDCoCBTb21lIEludGVsIGJhc2VkIHN5c3RlbXMgcmVxdWlyZSByYXcg
TVNSIGFjY2VzcyB0byB1c2UgdGhlIGZsdXNoCivCoMKgwqAgwqAgTVNSIGZvciBNRFMgbWl0
aWdhdGlvbiBjb25maXJtYXRpb24uIFJhdyBhY2Nlc3MgY2FuIGFsc28gYmUgdXNlZAorwqDC
oMKgIMKgIHRvIHVuZGVydm9sdCBtYW55IEludGVsIENQVXMuCisKK8KgwqDCoCDCoCBTYXkg
WSB0byBwcmV2ZW50IGFjY2VzcyBvciBOIHRvIGFsbG93IHJhdyBNU1IgYWNjZXNzIGZvciBz
dWNoCivCoMKgwqAgwqAgY2FzZXMuCisKwqBlbmRjaG9pY2UKLS0gCjIuMjQuMAoKCg==

--tExhhjTeEMx2YhVb9V99CZxVYOnvqHjZH--

--kDw9EFYc3MFHsaWt0EszyYW1nbEIy8d52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Using GnuPG with Thunderbird - https://www.enigmail.net/

iQIzBAEBCAAdFiEEyxaUgysVmYyKexNvud0OTyTSWqAFAl3iERIACgkQud0OTyTS
WqCT8BAAkf/rRsm6MGNl4+1C9Az9RpKgwulZUT5tFfKpo8/AVKKFWBfyEVDSdKpY
2AIQ5HuRJJn1Jd/FKkWBbo7zv0R5Zl5oZ+eyzip/cWvoIsI+IPlEpfQSnu9+Z3RL
C1ekjanMd2Bm/tG60ybW0G0hGLoF3YMtZGP8x7eMQpHJ1NpJ7ErPCaA4zFgfyugM
kU8MYN+hw9IWvubfE1Rr9/yl6h3YS45vINybpe5qn0YkIw8OyeJvvIuf86caJEPS
JtplTDLHaH4Ptv36hEM4yUZyclY8m31kC+duMn0dLFTDoCELqDhK8bHzg8oBuYgQ
zc5IIigL0b5AM1p094pxis4gx3dXaem99HUtNLTEh/R5SKWQopUcK/HBVaT6E3wO
1h1NuJ5c2cs7xvr9ERExMZXNo+kV42WlDHpgcRbs2TBU4F0SoLDYge3yAH2A5f9y
PqB9Nc7iVyFqfGLMKzrW/AdPPxXCMdTMwfLb2nrscgAK6k7dVvklj/Gy4RvYKkMU
in7vuhslQCmy2oVfQT9mytnWQXZypn7B6LrROqNw2h8qlbDnyCbq7jRW/9tHwWja
3W7ZBpQQj+jS9mq2V/2iEvZqMi/VT6o0nyF3Rntaq6XiVqPHaZQHyWP7bphhnzbY
V8oyBMRXHzNTVlglsGqpkQFQdHqXb2aI4H4BiY79SMx4iUZ8pbc=
=d61e
-----END PGP SIGNATURE-----

--kDw9EFYc3MFHsaWt0EszyYW1nbEIy8d52--
