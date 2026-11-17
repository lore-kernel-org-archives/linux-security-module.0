Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933415;
	b=gDBOKqNKeezR9W8yGRMVMi/RhrNprtfGIDGE2vSn/wfOCy+S/wcnav7gcUmFHlTHzVJy
	 ZZhDmIA1/hu9jk/VsOvlejXM/s9Bcewm+O7duepiSWAuxYx4Zo5i59EU3vO8+vXGlW+VU
	 aVsYZdPqXJu/wJAhsZtJtN0RDCqmEZSXZyoIplXLO5gaR05sJIozl6PeUVswm4oWZ3/xp
	 swq9QWtdYqZ/x2pz5BuNQRQSsOtlnzAg+kwgZwCv35Y3uJwbq1gzLQMwCkowkoqipAzTf
	 CP1O7MPTrH5o0cnB78zSN9gfGwxgo/lefSCt75MUkrIRiEk5NOcfNTkFKvUjkRaeDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933415;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LtO2Y97atFfjM45o/5R+9MnpH4sUAPyrAmnZSjvt41g=;
	b=qIsnfy6pD91aqWv31q3JynyxqI+ro0FA2P1jmbLtNl2/wuP2Xo39wf/S+dAyJ4uHcVaC
	 mqwVyVSdF1NaAgoFZ05wTIp7ebMN7EMLby7V/7xQsIwVzM62yq/iVX9Vsdsntpxcc5SCe
	 X+YJGUj3vLYrZnNuzBeEioQ0BU9kYpWhutOi8ADkiUGGQZViPvvjHmnY//GmylZMR2SUz
	 ZPF5Tf7GN0DqftOwsdboFC0z3MtIBIXJ78eOtuiuFZ/ft19XxInaQek2x774+bVVBElTN
	 chlWx6mbGRPJV7TzcAZIQ6T3zT6teFKDLapD+RYbQZo/ed6KQELHHvbAEsJsBJcZpjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="E/8v1Q0f";
	arc=none smtp.remote-ip=91.218.175.220
Received: from mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37941606A32A
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 16:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37941606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E/8v1Q0f
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wITi1xWZ2npOttf0kmXzox4ZAbCuBGj497SvMh9Y7rU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794933413; v=1; x=1795538213;
 b=E/8v1Q0ft74i1SikdgnSuuEymGQNmfur10hKj6GLML9Vu2YOVGsrVOp6PZ3VIQqpJBY0/u8I
 uR7Z7yUumqSjY2Lzw0279VELezvwz6mF7ecvyusS6pfKkkII4ByYCXYkvB3dtULCBKD9VS0ZVsM
 TBFvwmtYuVO+CnRJ4EDQZNgI=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f9f8caa2c26511e5;
	Tue, 17 Nov 2026 16:36:53 +0000
X-Mizu-Trace-ID: f9f8caa2c26511e5
X-Migadu-Flow: FLOW_OUT
Date: Tue, 17 Nov 2026 16:36:54 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>
CC: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_userns=3A_security=3A_Inform_LSMs_?=
 =?US-ASCII?Q?of_capability_check_during_userns_creation?=
In-Reply-To: <20261117-brennen-tastatur-ekelhaft-22ee93d5200a@brauner>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev> <aveDlb6PlPSVoLD9@hallyn.com> <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev> <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com> <20261117-brennen-tastatur-ekelhaft-22ee93d5200a@brauner>
Message-ID: <69BA4071-048F-4D90-9936-4B4856AABDF7@linux.dev>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 November 2026 16:31:16 GMT, Christian Brauner <brauner@kernel.org>
wrote:
>On Sat, Nov 14, 2026 at 08:34:07AM -0600, Serge Hallyn wrote:
>> Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:
>> 
>> > On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn" <serge@hallyn.com>
>> > wrote:
>> >> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
>> >>> Right now security_capable() gets called in create_user_ns() to
>snapshot
>> >>> whether the parent could setfcap, but the LSM gets zero context on
>where
>> >>> the check actually came from. It is the same story as setid: without
>a
>> >>> dedicated flag, security modules cannot tell this apart from regular
>> >>> capability checks.
>> >>>
>> >>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
>> >>
>> >> This should be patch 1/N in a set that introduces a user of it
>> >> in some lsm.
>> >
>> > hmm. Did you read Christians suggestion?
>> 
>> I did, when he first sent it. Actually it seems to me that what the
>> lsm would really like to know is that this is not for an immediate use
>> of setfcap, but possible future use. But that doesn't really matter. I
>> wasn't judging the patch. I was just going by what i believe is
>> general lsm subsystem policy.
>
>My main point is this: right now security_capable() doesn't actually
>specify what specific action it denies. I think we would be much better
>served if we had an enum that would allow us to annotate places where it
>matters what specific action is checked. I would make use of this in bpf
>lsms.

Does this patch look okay to you? Would you like any improvements? (Except
from adding a user) :)

>

--- Thanks!
