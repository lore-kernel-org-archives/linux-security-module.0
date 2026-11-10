Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271766;
	b=tdYcy/jOXAiGtOEcOnVHUo1Nu/f+d0MJBMWDzCqNeB/kWtnzTt4ABFrLin/ejfolCLMd
	 rwl4u3HPIEQ+TiiM23iJXjGNEHZcoO5J13WmhXe5qgXlDVSQdeqL6ywvxi9lMIOb5i8Se
	 i+rQaX7PYkx4iEadcaeO7ak6/rY+zjpQBcRqe0KPR/zaYNxV+M7oI3xRnB0pe9awtg3rT
	 sOFI1PdS+6NUgSIeNnqacebMf+e/eVVwZWCdFvwOqIXGQoe6cmiAsFcQDWpnJgiqypR6E
	 71qZFeJo9EWg+C/Bwyf6c7xdFY/eHbN2bzY8HTmp8ddDgWyR329JPap2BypMNcTyl4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271766;
	h=DMARC-Filter:X-Originating-IP:X-Works-Smtp-Source:Received:
	 DKIM-Signature:X-Session-ID:MIME-Version:Message-ID:Date:From:
	 In-Reply-To:References:Importance:To:Cc:Subject:X-Originating-IP:
	 X-Works-Send-Opt:Content-Type:Content-Transfer-Encoding;
	bh=bsgjQJ3EYXzJGz3xRscjU4VTksEqDVhrhriqpZCPFik=;
	b=x+pQ5tPRjTvnV7ztndzVWgeOe7G5HCTCTdzQtL+mW7pSlQw5Jo7iuR7RcG9xGNnXmXWl
	 ug1ZwThGI+kvw2lSB6Wi/kuPOVgplGbw2VABg0mQwgyRlSrsJGh2H35KiFD3EUAKWbMhQ
	 9HhBsFeWzc2nG/f9URwCI1Mwo08sHfLluOBsk3Px8J0X6sQjodTu/cTMER/+yGJz1vODI
	 sRuorONpDxerobR+YVdO/206g5LlL7A9RK7rMwd46OICWyJDrZUSG5ToKqTNjRfO0bF36
	 w69YxQZZdiQaGY4JjrU9YKOKbn4bBYyLB9THYx+5cwp6819BBkBG8sM7H1nLtHsm72g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=naver.com;
	spf=pass smtp.mailfrom=naver.com;
	dkim=pass header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=WNb8fLhx;
	arc=none smtp.remote-ip=114.111.35.29
Received: from cvsmtppost09.nm.naver.com (cvsmtppost09.nm.naver.com [114.111.35.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13C606A321;
	Tue, 10 Nov 2026 00:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A13C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=WNb8fLhx
X-Works-Smtp-Source: PXYqKotlFqJCpNmXFxKlWHF0
Received: from nv1s-hmac-real-35 ([10.180.31.91])
  by cvsmtppost09.nm.naver.com with ESMTP id wgnGdBkoSfKe8lF1iOXH3g
  for <multiple recipients>;
  Tue, 10 Nov 2026 00:49:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1794271756; bh=bsgjQJ3EYXzJGz3xRscjU4VTksEqDVhrhriqpZCPFik=;
	h=Message-ID:Date:From:To:Subject:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=WNb8fLhxEBp1860EYpdJzxnND8WXrbm7nC3C9Wv0nm9zm9lLqP3ZZXvFf/V4Mz1j2
	 4vUQ7isPb8BT65Hhm7Rk1kiCLgHOXUMPNisDRzhcZ4NaDsyWjUHUFfG+ZfZYz7beon
	 O53Yy/YqGdQOCMA9qsMXZ26BKo8gArDycpj7/ec87vWUKkJCvwzwWGsIaOHkPTcIkB
	 80vAQGg+iba4PQmsfwvnEeuWZFFraq/8fbc7iGC536iYftoJllvj92C/MmLNncwuGH
	 gnssj+7KPIeTx/1cLUpyyTd3XOQjH9faRYMdldVVfqDRECgYJMnlx+375HWyaOnhr5
	 oMtNCMkXIl0lw==
X-Session-ID: a39ff1babf02021ea48d0645a846145596af51b8900248f4feaf74578daa0da2
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <e360517ba7fa8262912a5c01b224ad9@cweb016.nm>
Date: Tue, 10 Nov 2026 09:49:16 +0900
From: =?utf-8?B?7JaR7Iuc7J2A?= <didtldms2525@naver.com>
In-Reply-To: <20261109.iej8biD4ohph@digikod.net>
References: <20261106120004.90041-1-dennylin0707@gmail.com>
	<20261109.iej8biD4ohph@digikod.net>
Importance: normal
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
	=?utf-8?B?SHVuZ3l1IExpbg==?= <dennylin0707@gmail.com>
Cc: <hannes@cmpxchg.org>,
	<surenb@google.com>,
	<peterz@infradead.org>,
	<mingo@redhat.com>,
	<juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>,
	<bsegall@google.com>,
	<mgorman@suse.de>,
	<vschneid@redhat.com>,
	<kprateek.nayak@amd.com>,
	<cerasuolodomenico@gmail.com>,
	<linux-kernel@vger.kernel.org>,
	<sashiko-bot@kernel.org>,
	=?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gc2NoZWQvcHNpOiBDaGVjayBDQVBfU1lTX1JFU09VUkNFIGluIHRoZQ==?=
	=?utf-8?B?IGluaXRpYWwgdXNlciBuYW1lc3BhY2U=?=
X-Works-Send-Opt: +wedpz0vjHmZFxiqW63nFBmmjAuljAudKxt/KxKXKq0YEu9YKBmm
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBOb3YgOSwgMjAyNiBhdCAxODo1MDo1MiArMDEwMCwgTWlja2HDq2wgU2FsYcO8biB3
cm90ZToKPiBUaGlzIGlzIGRpcmVjdGx5IHZpc2libGUgd2l0aCB0aGUgbmV3IExhbmRsb2NrIGNv
bnRyb2wgb2YgY2FwYWJpbGl0aWVzLgoKCkkgcmVwb3J0ZWQgdGhlIFBTSS9MYW5kbG9jayBDQVBf
U1lTX1JFU09VUkNFIG1pc21hdGNoIHByaXZhdGVseSB0bwp0aGUgbWFpbnRhaW5lcnMgb24gTm92
ZW1iZXIgNCwgMjAyNiwgYWxvbmcgd2l0aCByZXByb2R1Y3Rpb24gcmVzdWx0cy4KCkkgdGVzdGVk
IEh1bmd5dSdzIHBhdGNoIG9uIExpbnV4IHY3LjQtcmMxIHdpdGggTGFuZGxvY2sgQUJJIDEyIGFu
ZApjb25maXJtZWQgdGhhdCBwcml2aWxlZ2VkIFBTSSB0cmlnZ2VyIGNyZWF0aW9uIGlzIHJlamVj
dGVkIGFmdGVyCkxhbmRsb2NrIHJlc3RyaWN0cyBDQVBfU1lTX1JFU09VUkNFLgoKTmljZSBjYXRj
aCBvbiB0aGUgdXNlci1uYW1lc3BhY2UgaXNzdWUgYXMgd2VsbC4gVXNpbmcKZmlsZV9uc19jYXBh
YmxlKCkgd2l0aCAmaW5pdF91c2VyX25zIHJlc3RvcmVzIGJvdGggdGhlIGluaXRpYWwgdXNlcgpu
YW1lc3BhY2UgY2hlY2sgYW5kIExTTSBtZWRpYXRpb24uCgpSZXBvcnRlZC1ieTogU2lldW4gWWFu
ZyA8ZGlkdGxkbXMyNTI1QGpudS5hYy5rcj4KVGVzdGVkLWJ5OiBTaWV1biBZYW5nIDxkaWR0bGRt
czI1MjVAam51LmFjLmtyPgoKVGhhbmtzLApTaWV1biBZYW5nCg==
