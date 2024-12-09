Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42772F3B
	for <linux-security-module@vger.kernel.org>; Mon,  9 Dec 2024 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733710066; cv=none; b=E48K2b3Ml6Hw/IOs8DVO2zGF5MlMR3nOQYWxBxjZ5W54abNy7Hb8PG3AU4WY0LxAmGGtFdnM1+7bQwuklsI7R8rIPSLREGoho5ne0UlnTzlO7xwWFks/uPOsWAR0Hs/Vei036HidOjNHIDCtHWyQrPCmYPyg9VUI3JwJwq2oaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733710066; c=relaxed/simple;
	bh=1iiyWDBdy8rwFrN5yxCTMUsEF+u5xpFdLUj9KYnn/ZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gdKouJvG9SFDZq4/OJexWdg/qw7sLuvWTcxdKuEDdjdgx6j7lEYmdVlK8apu2evbQs0BaziBR+9Zm4TOz2el1CK9TfTezGNZMfC+FVVMHBHEdAe/7klmS2NctLHnjVJ27uP9njcB4oEOOj/wsnlbGO2aGmS2GbeI6f9KHoZfsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Zr6aXqUU reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Zr6aXqUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zTQ2BQdcVD/onCG/lnbzQWDomhnwonZovBvGq4EBxB0=; b=Z
	r6aXqUUEL2bAyUQnj+MJhm0DmrNfc3KJvbZVntPPWygQEKHDWRkR8yfyRRcVtZpk
	DrC7NtHlXBOpRVYpxdk9ruXVgai/iI97dPgRV95UXsrBeVxR77d0j/AppyUxBrBO
	h9g/BIUq5FNdmiiIAZXQZQHk40NkO2lnnO2pMrQld0=
Received: from 15074444048$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-147 (Coremail) ; Mon, 9 Dec 2024 09:52:01 +0800 (CST)
Date: Mon, 9 Dec 2024 09:52:01 +0800 (CST)
From: 15074444048  <15074444048@163.com>
To: "Casey Schaufler" <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, 
	lihaojie <lihaojie@kylinos.cn>
Subject: Re:Re: [PATCH] lsm: add reserved flag in lsm_prop struct
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <d772e32c-446c-4b89-bbe9-93f68e8cede3@schaufler-ca.com>
References: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
 <20241206114108.342819-1-15074444048@163.com>
 <d772e32c-446c-4b89-bbe9-93f68e8cede3@schaufler-ca.com>
X-NTES-SC: AL_Qu2YAfubtkkp5yiRZukfmkkagOg6UMK2uP8j2IJQOpl8jC7rwzwtd2NfBWbQ19OhIjuGtASLUzhB+/l2U4NTTpItLpj8F0CdpCrIOKPp5b9oLA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15d53f3e.1a1a.193a91dc96b.Coremail.15074444048@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kygvCgD3fyhCTVZnqFo4AA--.23295W
X-CM-SenderInfo: rprvilauuukiiuy6il2tof0z/1tbiIA+tUGdTLhqJlQAJsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI0LTEyLTA3IDAxOjMxOjExLCAiQ2FzZXkgU2NoYXVmbGVy
IiA8Y2FzZXlAc2NoYXVmbGVyLWNhLmNvbT4gd3JvdGU6Cgo+Cj5DYW4geW91IGNpdGUgd2hlcmUg
dGhpcyB3YXJuaW5nIG9jY3Vycz8KPgoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vaW5jbHVkZS9s
aW51eC9zdHJpbmcuaDozODksCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgv
Yml0bWFwLmg6MTMsCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvY3B1bWFz
ay5oOjEyLAogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3NtcC5oOjEzLAog
ICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2xvY2tkZXAuaDoxNCwKICAgICAg
ICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9zcGlubG9jay5oOjYzLAogICAgICAgICAg
ICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3dhaXQuaDo5LAogICAgICAgICAgICAgICAgIGZy
b20gLi9pbmNsdWRlL2xpbnV4L3dhaXRfYml0Lmg6OCwKICAgICAgICAgICAgICAgICBmcm9tIC4v
aW5jbHVkZS9saW51eC9mcy5oOjYsCiAgICAgICAgICAgICAgICAgZnJvbSBrZXJuZWwvYXVkaXRz
Yy5jOjM3OgpJbiBmdW5jdGlvbiChrnNpemVkX3N0cnNjcHmhrywKICAgIGlubGluZWQgZnJvbSCh
rl9fYXVkaXRfcHRyYWNloa8gYXQga2VybmVsL2F1ZGl0c2MuYzoyNzMyOjI6Ci4vaW5jbHVkZS9s
aW51eC9mb3J0aWZ5LXN0cmluZy5oOjI5MzozOiBlcnJvcjogY2FsbCB0byChrl9fd3JpdGVfb3Zl
cmZsb3ehryBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSBlcnJvcjogZGV0ZWN0ZWQgd3JpdGUgYmV5
b25kIHNpemUgb2Ygb2JqZWN0ICgxc3QgcGFyYW1ldGVyKQogIDI5MyB8ICAgX193cml0ZV9vdmVy
ZmxvdygpOwogICAgICB8ICAgXn5+fn5+fn5+fn5+fn5+fn5+CkluIGZ1bmN0aW9uIKGuc2l6ZWRf
c3Ryc2NweaGvLAogICAgaW5saW5lZCBmcm9tIKGuYXVkaXRfc2lnbmFsX2luZm9fc3lzY2FsbKGv
IGF0IGtlcm5lbC9hdWRpdHNjLmM6Mjc1OTozOgouL2luY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJp
bmcuaDoyOTM6MzogZXJyb3I6IGNhbGwgdG8goa5fX3dyaXRlX292ZXJmbG93oa8gZGVjbGFyZWQg
d2l0aCBhdHRyaWJ1dGUgZXJyb3I6IGRldGVjdGVkIHdyaXRlIGJleW9uZCBzaXplIG9mIG9iamVj
dCAoMXN0IHBhcmFtZXRlcikKICAyOTMgfCAgIF9fd3JpdGVfb3ZlcmZsb3coKTsKCgoKPgo+SSBk
b24ndCBjYXJlIG11Y2ggZm9yIHRoaXMgYXBwcm9hY2guIEluY3JlYXNpbmcgdGhlIHNpemUgb2Yg
dGhlIHN0cnVjdHVyZQo+dG8gYXZvaWQgYSB3YXJuaW5nIGluIHRoZSBjYXNlIHdoZXJlIGl0IGlz
bid0IHVzZWQgc2VlbXMgcHJvYmxlbWF0aWMuCj4KCmRvIHlvdSBoYXZlIGFueSBnb29kIHN1Z2Vz
dGlvbj8KCg==
