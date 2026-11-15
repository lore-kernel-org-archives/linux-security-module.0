Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794762911;
	b=yhLZsEE+jCpXwu9YT6hB9LvmsacQzeJe2ebi1zSNfhmC/ay6RZU8BGsl1my7entVqInQ
	 DjoregUS1VlvjowcGyp7EhWk1A/2h8sXD89F57bjLFMSLhXUPJ+4qDRE+SFJ3iATjL1z3
	 A3iQ9bI87vr/EAKtmWc6FBqf8L+Mwb0kVByRc3Q9gJ/nvU0q1rjv7LbHg9BlrTHiVNNP9
	 oc4dqHxSSSKx0PCk5ot4Fs30/hmo9SChmmsi1Qbf19PeWPsYkiEkR9XfqVrHm/TvqY/KT
	 6jtPCXdo29c5iCoBULwgFfqWfnHoH8SU5yEBv3ulA6gX2Eoc/fOcDI9KRiB+xx4fnVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=i/f2WZeiXO9K0dCZJZKLy/fff1H6asbvoSir7SuBJCE=;
	b=PNbu19vGvkQDS8qzi7OX5m5q1oqPpVPJXR9VDIeVhY31tgPeSeviX6uPXFwnLmEZ2xHY
	 duhdhlXigDdM6sNpdm1oNfvCKwH4QDA0sDny+uout/qZoCXjXUYjmsNtdcjEADMLqpNmh
	 SsH+HsFGsg6SmBvT14zYggEgiGUwHX5XJyupsdSpKeAju74YrRXdEt49rueUIRb0BpFQA
	 RSudXdkVFHO1vXBI8tP5kojtyD3e2ty5c6cH0N7Ga74b7QqOnFXJe00O3PYYD8GSqxx44
	 jYcUbE6qL2I5lRewg8/0VxqWTqCcAxwmdt1weNa7Hi8BRpRvDlnYxFF04dxqmSj1sgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W3GbktQb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B27606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 17:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4B27606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W3GbktQb
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so690872a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 09:15:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794762909; cv=none;
        d=google.com; s=arc-20260327;
        b=bzKA1gxTyA6/k8oHAf1ho6Y4u7T0nCZ9a9nE4OAxVuqUtqe+snmSEjtZx27gM6OyMM
         T0ByODwloL+5j1LctIDxutYG6dtODLxJPZpwISMeTYdtpyhPyD3LSS2quqNbeWRVDGff
         qFAEUuIFa1bw3NfEj0cXFta1rwWVGWekxfxxtDJZY7zr+qxSWYE3wGZtwMxAKza0PPVO
         DABoOg1KXxRITbNiIAs9zbCORDXpH0GAVH6oilFFeT4BvsQuhiIDuweYKcQWNHqHqbZ/
         gZaJ0aJeDkMSLQ5eu5VqxUZbsOGWh7x+CPOX0RSGmAks3op9Iu758vTK5odytKb1aA0z
         rwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i/f2WZeiXO9K0dCZJZKLy/fff1H6asbvoSir7SuBJCE=;
        fh=zCpg4JMSmyMkOor06OHAjGwM2pDAH1PLbhEkOZQiINs=;
        b=i/DyqHHVXIIlqK/nZ9WbzAAK7q5eJnZsSNdvJYiyohv1MM7kBraZdfbkVw9ghCoZMr
         84BqhGwBnlfTdzYmT6Dj5SzBT/5k/8aPrPN77ilO1xN6sGFk9sWCIHC9xJ2b+6n3MKiF
         1/gpd17hUZFm1R/ShrTFczIrrX+1mtALm/r2zqILNeP5Y2GJFVBt21kQieBXovtc1qRP
         iJLPCFdRSyUbURgZF+q3lc7HMIT6R9utXsMBwgvGxU7aVfeXgYrL07vclQBjQHxUxSnv
         p5Rhf8nIJxqBcLilqa2JE/wu7Jb/M8zQ0VpxjHy54lx3H20nfUStfaKSjgpRzk6oFf/i
         LfNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794762909; x=1795367709; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/f2WZeiXO9K0dCZJZKLy/fff1H6asbvoSir7SuBJCE=;
        b=W3GbktQb854RrNWFgxsLIM9sXR7o5zcYLvDNn6J86pG2JWfIsCP+Xup2dplLtmef2y
         viDjZLHYXTNx+eubKcykAyXcOI2QfwKKpP+mcfU6UmsIXJnajLGorgh00HuyT8nOrhtv
         4PIE7QaI7VcaVCNujz4n40fgwLPRJdfsuxkznhRBz7FDUZhj9YJQ7RaI5heOy2GQ3vSz
         F8fDskxZULkcpsE83SeWrVO0Tf8UZwcqUHPKoJuq+EMrgmY6pp/5Ez059vC2TFdy4jtl
         gwzWBabdTIr2RHn/ruu9xahIF/kuGlkyDxxvK5qYSCVjXr2mck47GglR0LItLZ2kDDeI
         l9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794762909; x=1795367709;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i/f2WZeiXO9K0dCZJZKLy/fff1H6asbvoSir7SuBJCE=;
        b=G3stYwqWFkT9wfRLkxkBAgZCmW9a6nD8leK51ylAAzl2hWBx/w3ruZebK63/goin+n
         ykOnjPjtAKlpxzK3qNpdVg0sgHhXb5vD5MpoNpNDLmp6bo6RpKDkbpGpZLjJe4ibL5sl
         o0h5VyztBKg55lcYAWq2ZzodyQe4IIfdWUrSDkfsijB9qfvgTryQgpsPIiZuFP/SPHzQ
         dmasar+wIs2BWP0AXL2M6xbIRBPP9ePTfi9EFCzhXFriFPx0tMTWvByqfAESrlNcL1Xf
         SAOp1SWmI7yox0Zc/kzPSoKp3GNv97bAiX9w2cJ5l+L+O47pwjmFOB3HpERivRLXj8MN
         eSbg==
X-Gm-Message-State: APuU4Z+Inw0REa75mlPpNSyikIPwgtfRfyV1Be/0YlammSVJuJQQhmhF
	LYMTjrkMgyCU4+BWRrb1uWBwyPVPfzoU0cjV1/KgOcFgaVn71uxl+KoxVaLmsVa9vRN1B6ai0qB
	Had7nJKDZ3m19q1XuWDiFuHWIwzQ6tA1LZrzn
X-Gm-Gg: AYBFou0Nyd6yvXw4dv8R3mWoHXFoqH8WFwOvTNE5+Z/oLjOGzV8vEvQ28zqWBEbJ0nX
	+MiPFuEYkseNMZwjUv2vwUOO2D3trm02fNZ0Ip5gXksEdfWoeqfzJBZ5IAXR4ZYF63EDqA9h3Xo
	2vFK/xIhw0xYqZDiCoh7/dbt9WI30Z41g9XrQ00oK94GYaiod3iQfbur4HIDBEpqo/js9SaiSHO
	wT5bQIL9abYyOtoSvECuGUpjzbAEZ2nXkgK1rz3K7Feirv8G2FzBJgUzKzpDep96jS1bKaIgOjR
	7+FxshSm4DejlD1/m/o/nLRydtlZ3PSSuNpgKlxl4hTDWhZRFQOUlaC9DySzqP78LVhSEpbbm4o
	glHABYq2mS5bYUdU1egKi3Jyx2cZEcgfkWUhJgLIHelCUAZx1hGdXETIufEmJSNVhEMrprI8fK2
	9n392V1trPY4goR+q+UOwn1tT4V2rrYX9AKvEPreZ4Rg==
X-Received: by 2002:a17:906:9c89:b0:c2d:c6e7:9e9a with SMTP id
 a640c23a62f3a-c509634a669mr673667566b.11.1794762909074; Sun, 15 Nov 2026
 09:15:09 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Terence White <terrywhite2025@gmail.com>
Date: Sun, 15 Nov 2026 17:14:57 +0000
X-Gm-Features: AclHuK-RnMRqnPPMMQKyxhQyQCEbnp4XsKIdZYejPW-FRpDhv1r9fWB74lY-N3Y
Message-ID: <CANkf1tZeotONOj+uYxE0k3BT_mrZpPyaYDA0vj9zFEbY2zYMrw@mail.gmail.com>
Subject: [PATCH] security/landlock: Add KUnit test for mixed valid and unknown
 namespace bits
To: linux-security-module@vger.kernel.org
Cc: gnoack@google.com, mic@digikod.net
Content-Type: multipart/mixed; boundary="000000000000a70ae7066053cdd8"

--000000000000a70ae7066053cdd8
Content-Type: text/plain; charset="UTF-8"

Good evening,

This patch adds a KUnit test case (test_ns_types_to_bits_mixed) to exercise
landlock_ns_types_to_bits() with a mixed bitmask containing both a valid
namespace type (CLONE_NEWNS) and an unknown high bit. This verifies that
the WARN_ON_ONCE truncation guard behaves as expected under
partial-taint inputs.

Tested locally with all 40 KUnit tests passing successfully.

With kind regards,

Terry White

--000000000000a70ae7066053cdd8
Content-Type: application/octet-stream; 
	name="0001-security-landlock-Add-KUnit-test-for-mixed-valid-and.patch"
Content-Disposition: attachment; 
	filename="0001-security-landlock-Add-KUnit-test-for-mixed-valid-and.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwi3fxds0>
X-Attachment-Id: f_mwi3fxds0

RnJvbSAwNTJkMzVjOWY4MmRmYzcyNzVmZTIzMzU5ZjZiNmVjOGQ3MjQyZTE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUZXJyeSBXaGl0ZSA8dGVycnl3aGl0ZTIwMjVAZ21haWwuY29t
PgpEYXRlOiBTdW4sIDE1IE5vdiAyMDI2IDE2OjU3OjMzICswMDAwClN1YmplY3Q6IFtQQVRDSF0g
c2VjdXJpdHkvbGFuZGxvY2s6IEFkZCBLVW5pdCB0ZXN0IGZvciBtaXhlZCB2YWxpZCBhbmQgdW5r
bm93bgogbmFtZXNwYWNlIGJpdHMKCkFkZCBhIEtVbml0IHRlc3QgY2FzZSAodGVzdF9uc190eXBl
c190b19iaXRzX21peGVkKSB0byBleGVyY2lzZQpsYW5kbG9ja19uc190eXBlc190b19iaXRzKCkg
d2l0aCBhIG1peGVkIGJpdG1hc2sgY29udGFpbmluZyBib3RoCmEgdmFsaWQgbmFtZXNwYWNlIHR5
cGUgKENMT05FX05FV05TKSBhbmQgYW4gdW5rbm93biBoaWdoIGJpdC4KVGhpcyBlbnN1cmVzIHRo
ZSBXQVJOX09OX09OQ0UgdHJ1bmNhdGlvbiBndWFyZCBmdW5jdGlvbnMgY29ycmVjdGx5CnVuZGVy
IHBhcnRpYWwtdGFpbnQgaW5wdXRzLgoKU2lnbmVkLW9mZi1ieTogVGVycnkgV2hpdGUgPHRlcnJ5
d2hpdGUyMDI1QGdtYWlsLmNvbT4KLS0tCiBzZWN1cml0eS9sYW5kbG9jay9ucy5jIHwgMTUgKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3NlY3VyaXR5L2xhbmRsb2NrL25zLmMgYi9zZWN1cml0eS9sYW5kbG9jay9ucy5jCmluZGV4
IDA2ZDk3ODQ3NC4uZDgyMDI4OTQyIDEwMDY0NAotLS0gYS9zZWN1cml0eS9sYW5kbG9jay9ucy5j
CisrKyBiL3NlY3VyaXR5L2xhbmRsb2NrL25zLmMKQEAgLTIxNyw2ICsyMTcsMjAgQEAgc3RhdGlj
IHZvaWQgdGVzdF9uc190eXBlc190b19iaXRzX3Vua25vd24oc3RydWN0IGt1bml0ICpjb25zdCB0
ZXN0KQogCX0KIH0KIAorc3RhdGljIHZvaWQgdGVzdF9uc190eXBlc190b19iaXRzX21peGVkKHN0
cnVjdCBrdW5pdCAqY29uc3QgdGVzdCkKK3sKKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0JVRykp
CisJCWt1bml0X3NraXAodGVzdCwgInJlcXVpcmVzIENPTkZJR19CVUciKTsKKworCS8qIGNsYW5n
LWZvcm1hdCBvZmYgKi8KKwlrdW5pdF93YXJuaW5nX3N1cHByZXNzKHRlc3QpIHsKKwkJLyogY2xh
bmctZm9ybWF0IG9uICovCisJCUtVTklUX0VYUEVDVF9ORSh0ZXN0LCAwVUxMLAorCQkJCWxhbmRs
b2NrX25zX3R5cGVzX3RvX2JpdHMoQ0xPTkVfTkVXTlMgfCAoMVVMTCA8PCA2MikpKTsKKwkJS1VO
SVRfRVhQRUNUX1NVUFBSRVNTRURfV0FSTklOR19DT1VOVCh0ZXN0LCAxKTsKKwl9Cit9CisKIHN0
YXRpYyB2b2lkIHRlc3RfbnNfdHlwZXNfdG9fYml0c196ZXJvKHN0cnVjdCBrdW5pdCAqY29uc3Qg
dGVzdCkKIHsKIAlLVU5JVF9FWFBFQ1RfRVEodGVzdCwgMFVMTCwgbGFuZGxvY2tfbnNfdHlwZXNf
dG9fYml0cygwKSk7CkBAIC0yMjgsNiArMjQyLDcgQEAgc3RhdGljIHN0cnVjdCBrdW5pdF9jYXNl
IHRlc3RfY2FzZXNbXSA9IHsKIAlLVU5JVF9DQVNFKHRlc3RfbnNfdHlwZXNfdG9fYml0c19hbGwp
LAogCUtVTklUX0NBU0UodGVzdF9uc190eXBlc190b19iaXRzX3NpbmdsZSksCiAJS1VOSVRfQ0FT
RSh0ZXN0X25zX3R5cGVzX3RvX2JpdHNfdW5rbm93biksCisJS1VOSVRfQ0FTRSh0ZXN0X25zX3R5
cGVzX3RvX2JpdHNfbWl4ZWQpLAogCUtVTklUX0NBU0UodGVzdF9uc190eXBlc190b19iaXRzX3pl
cm8pLAogCXt9CiB9OwotLSAKMi40My4wCgo=
--000000000000a70ae7066053cdd8--
