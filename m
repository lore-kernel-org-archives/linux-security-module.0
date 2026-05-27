Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45552481DD
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844080; cv=none; b=F7/SRdRe3e6vdiu9gBY9V4mEapqHsoHZtwSEE3ple+oUtMVQZfNj8CeS+kSC+6ZNBxlZwCsUqub01/YKjkny+cz4UwcPzw+UXW4JP8IhxJueZtubvG9CCfpbgv70UColxDRzQ7tq/UhLZmDHXKU4rcmJCMdopIwG5D8MikVUalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844080; c=relaxed/simple;
	bh=HnKvw7PgxNh1nZ2RPWWPJ4Olv4bGTCFTTCcF4W8EeWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTRZtx3Wcn5hsLBbsBUbm5YKLPLMPKhvqW+xGS6shAlziIrE9wD7nmXubRxaGVW5txDDm1NBkt6MjBO74XAsZiSCSQwWVAvBZLm8h0tkZIo7MwWe/gen/4UK6tpYImDukMLBJZpKQl6I1+/43REjPoI/jdJp7wNkUMLiZxIgVEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Mqq2x95U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b8fhYTSB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Mqq2x95U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b8fhYTSB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 96FA7EC01E1;
	Tue, 26 May 2026 21:07:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 21:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779844078;
	 x=1779930478; bh=dexCOR/zTqEUlbBVPSeZHZuztogDMHbsbuEeBDdz+cI=; b=
	Mqq2x95UD+Wt9aCsqHXJTl85ObuwfXpdAzMxGuGma6xQ+UcJCUgUU8ML9iBPxix4
	iRGvBHkc2rXmR4kCw2GARwxWmconUlMak5Fc5lrR0A+9+VEUmxT7pdC9EkYefQHJ
	JkSHK0L61kNuOBzLYMwocWQRhwZqIFBVMNO+tCHz/0zrwW0xIZm7BhgBy1UY6EJz
	8m8zODjlYcXnzixjmI9rke/ftUgDl3JbuzWdpcHJUmcMe8mG/VbNQQ7X5hLEqxar
	92vtngHSA5EUzHZN7BvJXPLNQrLCguJMWMR/gkfL/Bjes47lfn5MKRsnfztXVDwU
	riWwiV5uqR5eKcjGn4XL9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779844078; x=
	1779930478; bh=dexCOR/zTqEUlbBVPSeZHZuztogDMHbsbuEeBDdz+cI=; b=b
	8fhYTSBXCScwk06AiyQyrjZMtrrCHVLex+9viJbNHuuaPzfEfxrRD8ULoyPnRp2T
	k9wJ03T4nf9fkqggXz5pgzzvvo6nc7u6u1p2SJzyG6NtanzYR+8Uq07ZdWlLwrQK
	F4hSYtrW7f6HHsRXyt3rx8vJiTIYgO1ochaS3H2ml4di/niu9gPQiwaovrTJPpMn
	QynqueYkXevPr8ZjfBrkh7uCSnSfH7OOs19hH6QJhZggOaMy8pO2ulgWjWI88yQf
	fbc9oMtDlyu6wNJPUytRnlNibOGK4nAeQKAPAEbbHx9WerkfnPhT8i+URLPlPlOr
	0sLq3wY7C6lUmBIRJSxSQ==
X-ME-Sender: <xms:7kMWalSNuvF_gTB6AtO0Da1eLZf9_JCbWcDkaZs7fR9Q0aPt1mhT-Q>
    <xme:7kMWaifmSKBRFWb4KOi1G3BHpdMU7uN-mTej2pTrqnUJ_PztCH8Z_jfzmpsATCnZB
    DgvEp1x6GrFmDOJf3SkIGIUIkDxY3UghzJLlH4rZWqdyKaAXRM2gzs>
X-ME-Received: <xmr:7kMWakpjiARqRXTcxnhujHU-gj35wEjQ0UbywnXD89MX91FcLotorH70_jqxawSFhdQXAdLRf8ZvoM7Ykw>
X-ME-Proxy-Cause: dmFkZTECaUPFoWuEeUw8ijRXnrCey8QdX+YR0pkTR5u1gzbzjQD/668K0Mn0bRI7gF/2f2
    9tfEHzvkQl2Lz/VI2beEAHyhDPVV20FFmyunwkJzWJxiP++Y064G8C/iRpkMmgpnlXQHjz
    4HvmKCttE1Yd3wJUd9IGBbCKBZLf6XV176FEOBajatunOUmF4CD0ierPX1bSwUbUa+AWux
    nl2d6M1QXG4e/7YHQ1/Yx2wVd4tf8embO1ErqyLhdpFciZ8Wov7XeUMi1dxhQ7vu7pK4km
    ZFU4L+YXueFhKXwfbs9jtXHhouQJROsTEqNHSe0oeXkGWacbmBggpYjrLQEpujubstOVIM
    xs4rCCoFVMo8Awt2Z5KJIvaQHoskwsfuJOiu1nxkmNCVuREtvcaQjMXzzaUakCoh3nhezX
    Gx4kvcZiDhUYZqh+OO/XgVVFAerQXPaeBs8woEUnNWZZ6/QHfSjMcOf00Utp3i/Cys/asa
    YQRmPzIkXlIeFnHLaFdGins+cyPI3ax7BQs1PAutnl7AY+0RaY607n0oQwBguLsl+/7KCg
    wqrGVWmTMnkiiZF0umrERAbDVX/cK2AdTu3FWEBPLzDqCslO/8ZDq1G9uz8s3H+N7dIsyf
    eNumWb8PciOPIZYjRq4QJ8zQYx1jAgTZAJgXlDdApFktDa7oqXn0jDxlYw8A
X-ME-Proxy: <xmx:7kMWaj8ybA9-IIPbPppfB3eHHDXhHpXFfOd1Rod-lyiM2kkMaUTdag>
    <xmx:7kMWagfOvyBrySqYL7iYBgTBwuZ7tjKNuszuaHhEvNi8aeJbVTkLmg>
    <xmx:7kMWatIhadQRDyuePRH8a8TDvzlbk76kzGbGfooBo1x5eVQzQk3jlw>
    <xmx:7kMWagiJxjwKiuY3snD4si_0_pQsEfK3_cVj3-NNFwpVlKj0eKqtZQ>
    <xmx:7kMWake1D4dZfTnH_abj-Grjz8Y5KMLWQWPOV3p8jk8o3z7rjWRcWQDV>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:07:57 -0400 (EDT)
Message-ID: <783db352-b8c4-42f2-85ca-ebf92705250f@maowtm.org>
Date: Wed, 27 May 2026 02:07:55 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] landlock: Add API support and docs for the quiet
 flags
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1775490344.git.m@maowtm.org>
 <b4d25793959493f0a8ef66f03feedac1a15e7595.1775490344.git.m@maowtm.org>
 <20260524.eiD0ruozieke@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260524.eiD0ruozieke@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/24/26 21:35, Mickaël Salaün wrote:
> On Mon, Apr 06, 2026 at 04:52:15PM +0100, Tingmao Wang wrote:
>> [...]
>> @@ -69,6 +100,39 @@ struct landlock_ruleset_attr {
>>  #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
>>  /* clang-format on */
>>  
>> +/**
>> + * DOC: landlock_add_rule_flags
>> + *
>> + * **Flags**
>> + *
>> + * %LANDLOCK_ADD_RULE_QUIET
>> + *     Together with the quiet_* fields in struct landlock_ruleset_attr,
>> + *     this flag controls whether Landlock will log audit messages when
>> + *     access to the objects covered by this rule is denied by this layer.
>> + *
>> + *     If audit logging is enabled, when Landlock denies an access, it will
>> + *     suppress the audit log if all of the following are true:
>> + *
>> + *     - this layer is the innermost layer that denied the access;
>> + *     - all accesses denied by this layer are part of the quiet_* fields
>> + *       in the related struct landlock_ruleset_attr;
>> + *     - the object (or one of its parents, for filesystem rules) is
>> + *       marked as "quiet" via %LANDLOCK_ADD_RULE_QUIET.
>> + *
>> + *     Because logging is only suppressed by a layer if the layer denies
>> + *     access, a sandboxed program cannot use this flag to "hide" access
>> + *     denials, without denying itself the access in the first place.
> 
> This is not 100% correct: if a domain only handles/denies/quiet read, and a
> parent domain denies write, open(, O_RDwR) would not generate a log,
> which is OK.

open(, O_RDWR) as one access request is denied by the child domain because
it also needs read.  For a open(, O_WRONLY), we will correctly generate a
log.

> 
>> + *
>> + *     The effect of this flag does not depend on the value of
>> + *     allowed_access in the passed in rule_attr.  When this flag is
>> + *     present, the caller is also allowed to pass in an empty
>> + *     allowed_access.
> 
> The audit/log part in Documentation/userspace-api/landlock.rst and
> Documentation/security/landlock.rst should be updated to take this quiet
> flags into account.
> 
>> + */
>> +
>> +/* clang-format off */
>> +#define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
> 
> I think this name is correct because this flag will be used by the
> supervisor feature, but otherwise it should be named something like
> LANDLOCK_ADD_RULE_LOG_QUIET.  Tingmao, do you think that makes sense?
> If yes, it should be explained in the commit message that this quiet
> flag may be used for some kind of notification...

Makes sense, will do.
