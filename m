Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480335CBDC;
	Wed, 12 Nov 2025 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914924; cv=none; b=UUtgWhsziUeZwd0IAz8KbNGYaO3obBOCNYVtuJ/rHhJJ5Om4HHzb5itfELElTmWSXFnZrx1HtNrS7EDTEgqL/lrQlaS2EW0i9ecCJxeP8cv7tikMN4WsJ0q7s7mtcKCjmbZ8EGv4llyqxJfWxmQd/bbqhTD60L7+GqiSs5rD2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914924; c=relaxed/simple;
	bh=VxJJx/bbFAlIloG/4NggwqEeBLSrxY79FnW5QIt8fFc=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=f32V2t1+PaJ+Wu+nMC4pNvpY0ks7s1DU+4ggA0P+opaIsAYZCUYKcLltNPHgzskhs7PCPeia8XGsKtBlsi1LZDLm3wqti1w/5KsQxQywDGRrJEHrQx16DWKCG4Bpm0s2DyTEclYLwDsL9zPRK2u2x1bMYcL9VBy3WqEIELYOzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from xujiakai24$mails.ucas.ac.cn ( [210.73.43.101] ) by
 ajax-webmail-APP-10 (Coremail) ; Wed, 12 Nov 2025 10:35:17 +0800
 (GMT+08:00)
Date: Wed, 12 Nov 2025 10:35:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6K645L2z5Yev?= <xujiakai24@mails.ucas.ac.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [BUG] landlock: sleeping function called from invalid context in
 hook_sb_delete()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20dd8187.9d18.19a75eadc43.Coremail.xujiakai24@mails.ucas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowAAH8Odl8hNpfAMBAA--.9475W
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/1tbiCQ4EE2kT1NWAjwA
	Ask
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8sClRoaXMgaXNzdWUgb2NjdXJzIHdoZW4gdW5tb3VudGluZyBhIHRtcGZzIGZpbGVzeXN0
ZW0gdGhhdCBoYXMgcHJldmlvdXNseSBiZWVuIGFkZGVkIHRvIGEgTGFuZGxvY2sgcGF0aC1iZW5l
YXRoIHJ1bGUuCkR1cmluZyB0aGlzIG9wZXJhdGlvbiwgdGhlIGtlcm5lbCByZXBvcnRzIGEg4oCc
c2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh04oCdIGJ1ZyBpbiBo
b29rX3NiX2RlbGV0ZSgpIChzZWN1cml0eS9sYW5kbG9jay9mcy5jKS4KCgpUaGlzIGJ1ZyB3YXMg
aW5pdGlhbGx5IGRpc2NvdmVyZWQgb24gdGhlIExpbnV4IHJpc2N2IGJyYW5jaCB2aWEgYSBmdXp6
aW5nIGZyYW1ld29yay4KSXQgd2FzIGxhdGVyIGNvbmZpcm1lZCByZXByb2R1Y2libGUgb24gTGlu
dXggbWFpbmxpbmUgdjYuMTgtcmM1ICh4ODYpLgpUaGUgdGVzdGVkIGtlcm5lbCBzb3VyY2UsIGNv
bmZpZ3VyYXRpb24sIGFuZCByZWxhdGVkIG1hdGVyaWFscyBhcmUgcHJvdmlkZWQgYmVsb3c6CiAg
S2VybmVsIHNvdXJjZTogaHR0cHM6Ly9naXQua2VybmVsLm9yZy90b3J2YWxkcy90L2xpbnV4LTYu
MTgtcmM1LnRhci5neiAgCiAgQ29uZmlnIGZpbGU6IGh0dHBzOi8vZ2l0aHViLmNvbS9qMWFrYWkv
S0NvbmZpZ0Z1enpfYnVnL2Jsb2IvbWFpbi9yZXBvcnQvMGM4NDRkNWY3YmNmMGFjMjFlZjRlZDg1
NDU5Njc2YWIyNjRlOGI2Yi8uY29uZmlnICAKICBSZXByb2R1Y2VyIHNvdXJjZTogaHR0cHM6Ly9n
aXRodWIuY29tL2oxYWthaS9LQ29uZmlnRnV6el9idWcvYmxvYi9tYWluL3JlcG9ydC8wYzg0NGQ1
ZjdiY2YwYWMyMWVmNGVkODU0NTk2NzZhYjI2NGU4YjZiL3JlcHJvLmNwcm9nICAKICBHQ0MgY29t
cGlsZXIgaW5mbzogaHR0cHM6Ly9naXRodWIuY29tL2oxYWthaS9LQ29uZmlnRnV6el9idWcvYmxv
Yi9tYWluL3JlcG9ydC8wYzg0NGQ1ZjdiY2YwYWMyMWVmNGVkODU0NTk2NzZhYjI2NGU4YjZiL2dj
Yy5pbmZvICAKICBLZXJuZWwgbG9nIChkbWVzZyk6IGh0dHBzOi8vZ2l0aHViLmNvbS9qMWFrYWkv
S0NvbmZpZ0Z1enpfYnVnL2Jsb2IvbWFpbi9yZXBvcnQvMGM4NDRkNWY3YmNmMGFjMjFlZjRlZDg1
NDU5Njc2YWIyNjRlOGI2Yi9kbWVzZy5pbmZvICAKICBBZGRpdGlvbmFsIHJpc2N2IGZ1enppbmcg
Y29udGV4dCAocmVwb3J0MCwgZXRjLik6IGh0dHBzOi8vZ2l0aHViLmNvbS9qMWFrYWkvS0NvbmZp
Z0Z1enpfYnVnL3RyZWUvbWFpbi9yZXBvcnQvMGM4NDRkNWY3YmNmMGFjMjFlZjRlZDg1NDU5Njc2
YWIyNjRlOGI2YgoKClRoZSBjYWxsIHRyYWNlIGluZGljYXRlcyB0aGF0IGhvb2tfc2JfZGVsZXRl
KCkgaG9sZHMgc19pbm9kZV9saXN0X2xvY2sgKGEgc3BpbmxvY2spIHdoaWxlIGludm9raW5nIG9w
ZXJhdGlvbnMgdGhhdCBtYXkgZXZlbnR1YWxseSBjYWxsIGlwdXQoKSwgd2hpY2ggY2FuIHNsZWVw
LgpUaGlzIHZpb2xhdGVzIHRoZSBsb2NraW5nIGNvbnRleHQgZXhwZWN0YXRpb25zIGFuZCB0cmln
Z2VycyBfX21pZ2h0X3NsZWVwKCkgd2FybmluZ3MuClRoZSBpc3N1ZSBzZWVtcyB0byBiZSByZWxh
dGVkIHRvIGhvdyBMYW5kbG9jayBoYW5kbGVzIHN1cGVyYmxvY2sgY2xlYW51cCBkdXJpbmcgc2Vj
dXJpdHlfc2JfZGVsZXRlKCkuCgoKSeKAmW0gY3VycmVudGx5IG9ubHkgcmVwb3J0aW5nIHRoaXMg
aXNzdWUgdG8gdGhlIGNvbW11bml0eTsgdGhlIGV4YWN0IGZpeCB3aWxsIGxpa2VseSBuZWVkIHRv
IGJlIGNvbmZpcm1lZCBhbmQgaW1wbGVtZW50ZWQgYnkgdGhlIExhbmRsb2NrIGFuZCBmaWxlc3lz
dGVtIG1haW50YWluZXJzLg==
