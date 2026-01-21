Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E6217F33
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955222; cv=none; b=nUQuuXw+aORC6F6ojpwC98X1RIz/gRpnl45yJKYyUvr1xYEwdLeFcocV21hJzddbfdN9MYt6z5P5OQTuv7GfWcW6w3JlwsuX5sCD2NcTgVy7hrcJp+MBsyoblJX2w2DY2lrhNS/MpJKHSUlSNSMA0hZVtFOOJpVvjeu356o/5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955222; c=relaxed/simple;
	bh=Q/aAB6HPWdr9y74Wh8H7rlmrmyf1h2p+nuR/FArCtWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR3A4IRMt3mbP7XigvL4CktP/RtajNhD6sAA6aM0frh43x3+u9uV276293esYXcCccihP1GFSUDZmdGIE5MyWqHKvgXbL6WUDcYMtt69xJNRfqad/T3CHFwB8vlOOdXZiMcNdRuOXljoGYHfwYxc2lq6IlxoNP87S+LoUoIg4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=nI6XCT9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjs4KaHB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="nI6XCT9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjs4KaHB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B87E81D0008A;
	Tue, 20 Jan 2026 19:26:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 19:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768955218;
	 x=1769041618; bh=/OTL2kN+gthLXibO5CJ4M5dZkK5qmSiPgEMgivucWCE=; b=
	nI6XCT9w2OQ9gslpYorWTGUyBUn1xKaC0datTEcKP4Lu5IXZm81pBjdWhIu0Q9qe
	3QCpKoKbHNNIGngx1gSi4gS9+s71jmHTNxr0pGF6UYJ9Fu32XQxTxNLXBClZzeBu
	gN04yp6jVwSygk3GQwNRUTLGfgELDicDu1bs8mN07sN4HIbwxRD/zjprNmo+4Dlc
	CsUpmWH/JGvZqg5FpGyclSwkW5kTQQdRBHNZZJUymPyoUolq9raxUn4rOrQnPV7v
	feM8Dv/MxNMX4P6qoAwXDOe97eUxOFzqqNfYlihUOh+6x9KJrVO8Ciaoxlod/624
	jkLaXpO0zk0aJ0c+xuxItQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768955218; x=
	1769041618; bh=/OTL2kN+gthLXibO5CJ4M5dZkK5qmSiPgEMgivucWCE=; b=b
	js4KaHB2PfEhj6oHOcqkPvpVwi36PDZPTN42oyXysQ25MTHofBPo2zPkKbX0qPJ8
	AuLxTj7NaQlgQedCH7C3PUf97zLMCMESPd3chfGYTfUY+cKHIIuk0wgsYmPVJA+m
	bNdkyS6uTxKI33JODE/vdby219iZDrlfaTfNsfsG6hLaFRMfVUZ0g99fXYEnJCTK
	EbrhDyybNPY07ZywxEmFjb8EwXEuTXi4AFUCv15m6mewE5cxWT58hLnNX5hDqEPg
	SUZ/uE6vXpM7+KljBweJ28zx6Rcj/lzKUkLA2KcEJjdK6NPihdDGsT8e/P3rgGbc
	CS+JH/0xuuGSkSYqAemvg==
X-ME-Sender: <xms:UR1waYOu6_SEx844hvBj1ugQwJ3F3yS5HCunQ1A3m5czBuaK3rZ3Ug>
    <xme:UR1waeD6TxB7ByNoGta87VQSu3eczXIQqv1kxw4YtlBRBKizOFerm6lfn6htK0UKF
    Ibv6McpVtH4slqHOgqjt8TaHQvjZo17pVzBsxKIMbB1XJoUDzs9bCqC>
X-ME-Received: <xmr:UR1waVfPf-dzz1dSgQ37SbHl6ZTlrWX4TtuIzVlcMx-STfryEk_a2fHynAzOym_XmKVnpj5tyOhX3ZG7kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepff
    fhheegfeegteekieeggeevvedvteeiledvgeevgefhffekgeeluedtieevudehnecuffho
    mhgrihhnpehmrghofihtmhdrohhrghdpkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    sehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehuthhilhhithihvghmrg
    hljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithih
    qdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghmrg
    hsthhhrdhnohhrfigrhidrrghnrghnuggrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pehmrghtthhhihgvuhessghufhhfvghtrdhrvgdprhgtphhtthhopehivhgrnhhovhdrmh
    hikhhhrghilhdusehhuhgrfigvihdqphgrrhhtnhgvrhhsrdgtohhmpdhrtghpthhtohep
    khhonhhsthgrnhhtihhnrdhmvghskhhhihguiigvsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:UR1wadOP0HAsRjCiZudjuXmxc_XXWdc8fj0idXxHGwGewdwdvj6HiQ>
    <xmx:UR1waVJdxyIOsJ_PjyZ4SPhK0CY_xfCm4KclyC64XlwlAyVf9sYYtg>
    <xmx:UR1wadJlCvESyIVUmWQi9bBx7ZHrK-3ZXdrH84QjirgNGQwm5yNzsA>
    <xmx:UR1waf5WQ3XHWmr1j3XQCbdrHizL-PuYgmSMeHkC5fvBFNnzAxyw6Q>
    <xmx:Uh1waShqvxF5DjGM1AcTdka_80mYlDo2ItxLqkLoVW2bqvA5zNvHIS7n>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 19:26:55 -0500 (EST)
Message-ID: <6a789aa9-c479-43f9-ac24-bc227f8388c6@maowtm.org>
Date: Wed, 21 Jan 2026 00:26:52 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Justin Suess <utilityemal77@gmail.com>,
 linux-security-module@vger.kernel.org,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251230103917.10549-7-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/30/25 10:39, Günther Noack wrote:
> The layer masks data structure tracks the requested but unfulfilled
> access rights during an operations security check.  It stores one bit
> for each combination of access right and layer index.  If the bit is
> set, that access right is not granted (yet) in the given layer and we
> have to traverse the path further upwards to grant it.
> 
> Previously, the layer masks were stored as arrays mapping from access
> right indices to layer_mask_t.  The layer_mask_t value then indicates
> all layers in which the given access right is still (tentatively)
> denied.
> 
> This patch introduces struct layer_access_masks instead: This struct
> contains an array with the access_mask_t of each (tentatively) denied
> access right in that layer.
> 
> The hypothesis of this patch is that this simplifies the code enough
> so that the resulting code will run faster:
> 
> * We can use bitwise operations in multiple places where we previously
>   looped over bits individually with macros.  (Should require less
>   branch speculation)
> 
> * Code is ~160 lines smaller.
> 
> Other noteworthy changes:
> 
> * Clarify deny_mask_t and the code assembling it.
>   * Document what that value looks like
>   * Make writing and reading functions specific to file system rules.
>     (It only worked for FS rules before as well, but going all the way
>     simplifies the code logic more.)

In the original commit message that added this type [1] there was this
statement:

> Implementing deny_masks_t with a bitfield instead of a struct enables a
> generic implementation to store and extract layer levels.

At some point when looking at this I was wondering why this wasn't a
struct with 2 u8:4 fields, but rather, a u8 with bit manipulation code.
While it is possible that I might have just misunderstood it, reading the
above statement my take-away was that a struct would have forced us to
address the indices with specific names, e.g. it would need to be defined
like

struct deny_masks_t {
    u8 ioctl:4;
    u8 truncate:4;
}

And it would thus not be possible to manipulate the indices in a generic
way (e.g. the way it was implemented before, given
all_existing_optional_access and access_bit, read and write the right
bits).

However, since we're now removing that generic-ability, should we consider
turning it into a struct?  (If later on we have different access types
that also have optional accesses, we could use a union of structs)


btw, since this causes conflicts with the quiet flag series and Mickaël
has indicated that this should be merged first, I will probably have to
make my series based on top of this.  Will watch this series to see if
there are more changes.

Also, this transpose and code simplification should also simplify the
mutable domains work so thanks for the refactor!

A while ago I also made some benchmarking script which I sent a PR to
landlock-test-tools [2], and earlier I tested this patch with it, and saw
some improvement (but it was much less in terms of percentage, which may
be due to the lower directory depth, or may be due to other unknown
reason):

TestDescription(landlock=True, dir_depth=10, nb_extra_rules=10)
  base.2:
    c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=1718.15, min=1663.00, max=275949.00, median=1696.46, stddev=437.52
    95% confidence interval: [1718.03 .. 1718.28]
  Estimated landlock overhead (vs no-landlock): 226.5%
  48bd90e91fe6.2:
    c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=1709.60, min=1633.00, max=280608.00, median=1688.83, stddev=441.83
    95% confidence interval: [1709.48 .. 1709.73]
    ** Improved 0.5% **
         ...
      [1660 .. 1669]:                                             [1660 .. 1669]: ###                                     
      [1670 .. 1679]: ##                                          [1670 .. 1679]: ###############                         
      [1680 .. 1689]: ######################                      [1680 .. 1689]: #################################       
      [1690 .. 1699]: ########################################    [1690 .. 1699]: ##################################      
      [1700 .. 1709]: ############################                [1700 .. 1709]: #############                           
      [1710 .. 1719]: #########                                   [1710 .. 1719]: ##                                      
      [1720 .. 1729]: ##                                          [1720 .. 1729]:                                         
         ...
    Estimated landlock overhead (vs no-landlock): 223.0%

TestDescription(landlock=True, dir_depth=29, nb_extra_rules=10)
  base.2:
    c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=3869.66, min=3727.00, max=272563.00, median=3813.42, stddev=666.18
    95% confidence interval: [3869.47 .. 3869.86]
  Estimated landlock overhead (vs no-landlock): 427.3%
  48bd90e91fe6.2:
    c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=3855.61, min=3697.00, max=271690.00, median=3804.82, stddev=682.74
    95% confidence interval: [3855.41 .. 3855.81]
    ** Improved 0.4% **
         ...
      [3750 ..   3759]:                                             [3750 ..   3759]: #                                       
      [3760 ..   3769]:                                             [3760 ..   3769]: #######                                 
      [3770 ..   3779]:                                             [3770 ..   3779]: ###############                         
      [3780 ..   3789]: ####                                        [3780 ..   3789]: ###################                     
      [3790 ..   3799]: ###################                         [3790 ..   3799]: ###################                     
      [3800 ..   3809]: ######################################      [3800 ..   3809]: ########################                
      [3810 ..   3819]: ########################################    [3810 ..   3819]: ############################            
      [3820 ..   3829]: ##########################                  [3820 ..   3829]: #####################                   
      [3830 ..   3839]: #############                               [3830 ..   3839]: #########                               
      [3840 ..   3849]: ######                                      [3840 ..   3849]: ##                                      
      [3850 ..   3859]: ##                                          [3850 ..   3859]:                                         
      [3860 ..   3869]:                                             [3860 ..   3869]:                                         
      [3870 ..   3879]:                                             [3870 ..   3879]:                                         
      ...
      [4980 ..   4989]:                                             [4980 ..   4989]:                                         
      [4990 ..   4999]:                                             [4990 ..   4999]:                                         
      [5000 .. 272563]: #                                           [5000 .. 271690]: #                                       
    Estimated landlock overhead (vs no-landlock): 424.2%

Full data including test with 0 depth, or 1000 rules:
https://fileshare.maowtm.org/landlock-20251230/index.html


[1]: https://lore.kernel.org/all/20250320190717.2287696-15-mic@digikod.net/
[2]: https://github.com/landlock-lsm/landlock-test-tools/pull/17
