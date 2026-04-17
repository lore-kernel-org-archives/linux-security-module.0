Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F73384250;
	Fri, 17 Apr 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425419; cv=none; b=InpmXiNMs0ld4IaToX0t08uV+CRdDSrHlrs6xK1Z6X/6sWqdeKmB2g8NrJ/7v32NY4DM42s5k6Uk9L318jvA2sQWD1sZw6sf61ObBI8Pmw3Dlls4DGKrn05jeTS9FIpmnLsY4J5LKVqE0hiT2hBqagmqztAeqiE6rgduzcbswFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425419; c=relaxed/simple;
	bh=S4dcWeuVgK07YA9NdYV4789SOwZl5m7tm7oGsUd7mxA=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=TkDKhjmvFFKXZuzfYADDJAUxsJMSs1/EOKfmV3BrsPv7u6/z83i99T4rzVA7Ukl7D0i5KnXQlHogmOXaNwTMPKHbEiv5mr5AXNXjxV68UJgg23QZ7OlRSoUFD0Fh4gRnG0FSA2eTUfCkzrALxwSeaqrWwkCQyZhTCmICxTx8Seg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=s36CMgk8 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="s36CMgk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=RovjmLRGIW0owxPnTzr3vZ3RpJmFX29v/NPKqpg+7UA=; b=s36CMgk8+xgaX
	VP8PoGgayKwhAn8pJfMlXHoQevl7oQgETdrYuQhDY2Ba5o2mOdl/gKyLgWftCtAn
	6jGuLV9QuGl6umj4+CAC1iICbkvV67pT0EiH4YDUqcu9BsGmgcp8UQRxHGygOlve
	DGp+Rw7NxABU9c8lKcTMbL1DTCUTuo=
Received: from 23009200614$stu.xidian.edu.cn ( [113.200.174.18] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Fri, 17 Apr 2026
 19:30:03 +0800 (GMT+08:00)
Date: Fri, 17 Apr 2026 19:30:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5b+X?= <23009200614@stu.xidian.edu.cn>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	paul@paul-moore.com
Subject: [BUG] landlock: warning in collect_domain_accesses via renameat2
 path rename
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <25536ce2.4391.19d9b3484ff.Coremail.23009200614@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BrQMCkC2Xbm8GeJpxCydAQ--.40111W
X-CM-SenderInfo: qstqimqsqqliuu6v33wo0lvxldqovvfxof0/1tbiAgUGCGng-OOc3
	wABsd
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBNYWludGFpbmVycywKCldoZW4gdXNpbmcgb3VyIGN1c3RvbWl6ZWQgU3l6a2FsbGVyIHRv
IGZ1enogdGhlIGxhdGVzdCBMaW51eCBrZXJuZWwsIHdlIGRpc2NvdmVyZWQgYSBjcmFzaCByZWxh
dGVkIHRvIExhbmRsb2NrIGR1cmluZyBhIHBhdGggcmVuYW1lIG9wZXJhdGlvbi4KCkhFQUQgY29t
bWl0OiA3ZDBhNjZlNGJiOTA4MWQ3NWM4MmVjNDk1N2M1MDAzNGNiMGVhNDQ5CmdpdCB0cmVlOiB1
cHN0cmVhbQoKUmVwcm9kdWNlciBhbmQgbG9nczoKT3V0cHV0OiBodHRwczovL2dpdGh1Yi5jb20v
bWFudWFsMC9jcmFzaC9ibG9iL21haW4vY2ViZDI3MDA3ZTgwNmUxNmNmMTVjYjFlMDIxNGMyNDA1
NGU4OTk4ZS9yZXBvcnQxCktlcm5lbCBjb25maWc6IGh0dHBzOi8vZ2l0aHViLmNvbS9tYW51YWww
L2NyYXNoL2Jsb2IvbWFpbi82LjE4LXN5emJvdC5jb25maWcKQyByZXByb2R1Y2VyOiBodHRwczov
L2dpdGh1Yi5jb20vbWFudWFsMC9jcmFzaC9ibG9iL21haW4vY2ViZDI3MDA3ZTgwNmUxNmNmMTVj
YjFlMDIxNGMyNDA1NGU4OTk4ZS9yZXByby5jCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCgpBbmFseXNpczoKClRoZSBjcmFzaCBpcyB0cmlnZ2VyZWQgdGhyb3VnaCB0
aGUgZm9sbG93aW5nIHBhdGg6CgpyZW5hbWVhdDIKICDihpIgc2VjdXJpdHlfcGF0aF9yZW5hbWUK
ICDihpIgY3VycmVudF9jaGVja19yZWZlcl9wYXRoCiAg4oaSIGNvbGxlY3RfZG9tYWluX2FjY2Vz
c2VzCgpUaGlzIGluZGljYXRlcyB0aGF0IGEgcGF0aCByZW5hbWUgb3BlcmF0aW9uIHRyaWdnZXJz
IExhbmRsb2NrJ3MgcGF0aCBhY2Nlc3MgY29udHJvbCBjaGVja3MuIFRoZSBjcmFzaCBvY2N1cnMg
aW5zaWRlIGNvbGxlY3RfZG9tYWluX2FjY2Vzc2VzKCksIHdoaWNoIGlzIHJlc3BvbnNpYmxlIGZv
ciBjb2xsZWN0aW5nIHRoZSBjdXJyZW50IHByb2Nlc3MncyBkb21haW4gYWNjZXNzIHJpZ2h0cy4K
ClRoZSBidWcgaXMgY2F1c2VkIGJ5IGNvbGxlY3RfZG9tYWluX2FjY2Vzc2VzKCkgdHJhdmVyc2lu
ZyBpbmNvbnNpc3RlbnQgb3IgaW52YWxpZCBMYW5kbG9jayBydWxlc2V0IGRhdGEgZHVyaW5nIHJl
bmFtZSBwYXRoIHBlcm1pc3Npb24gY2hlY2tzLCBsZWFkaW5nIHRvIHVuc2FmZSBtZW1vcnkgYWNj
ZXNzLgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpJZiB5b3UgZml4
IHRoaXMgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoK
ClJlcG9ydGVkLWJ5OiBaaGkgV2FuZyA8d2FuZ3poaUBzdHUueGlkaWFuLmVkdS5jbj4KClRoYW5r
cywKWmhpIFdhbmc=
