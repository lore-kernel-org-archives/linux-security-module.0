Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7D217F33
	for <linux-security-module@vger.kernel.org>; Fri, 23 Jan 2026 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206300; cv=none; b=Sv6UDRWtHCXyu1luTbQOfyM/p09zdWKnRgw+Q5+IVIQNyfMQMWdaKtyz7Fqf47uGWt6WGEmGD4GxTeigr4BHY4+iIdqv5zCwxwuUCOSFpE584u6WNLmxzuruIctOvhy79oZzQpnAGetVBc+wnEoqRlTzE9zhcOZajFk4P7eRwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206300; c=relaxed/simple;
	bh=9bLZn0wbvNXmBPmmVTBWjAiauLm4Z/1igFpkJh8gMiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaRkmwzTpxS67ChtHwG9sxx+UdjxBkucfvMualH7p9rOnWIHUUaYQYxTWD1SyM6odY/We9dwcuEoo4WS30AqfLuRk2Fb1cLPDckGbS8NGvxjx6M/gNcXjGbG+p/eon/QoTAr6gbozKMR+rPbvrYL97cFULumYdnVNcFTOLrgrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9ZzLTlw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9ZzLTlw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee0291921so22535165e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jan 2026 14:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769206297; x=1769811097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UdaFxWOvPA5kY+z9cG1sGRg386RAnTxqdimap0dHjsQ=;
        b=U9ZzLTlwNF5kLgizOrEdUqc8fpjHh/kiFVFxNTq/C1kahAtOJ+/dO9GuhdOCcJhVwO
         /OMWIk7v2yoi1jB54kWcynmx6qhOR/8idc0ZqM6kHUh0jShnOIzT6YXoZdXIRt16evo3
         ghlv46cX9+8NZ+UWr7h2e8hlcFmIIWeWZL/3d/oPQLjKvWhhTASGYe9zl6PKIxH6FHF8
         G7x3B5xKgMkF9FT7xeo5Fvidhd/pYOZF4w/KK549zbM825j79l9ZpiBCGJ2LVmLvA1Dj
         2mm+sB1vMoBfYxo7DEQXIpS7zqlbZQL4V41XLocgRnlxGSfFV0aj3hBx2XkBONN/3gZh
         i3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769206297; x=1769811097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdaFxWOvPA5kY+z9cG1sGRg386RAnTxqdimap0dHjsQ=;
        b=SMRxzSLuY6zulWX+k3CdXjnCSTRamSXNPotZF6uvCdihYWouRzOBostt1rlV0xatdH
         DizAYXBrywHbcT96lUG9pYwYxJEB/xDrAbTF610xBy443NUxb0qOJQ8aO1s2R2x0ZxC1
         wAlWV9jI+Onn3568ywvdYyPDVz62WHufGNPIbazw1g5k/9rfHT1Zd7n03hYf8psfcKSK
         RBz+k0Yr93FdQMu/e/bSb8I8PPhbZedCTwo4drzsj5adDIu9iY79uSMF1GqsgrJyiEHn
         lnRA+z+w93SBUgaeCKYXZB2jubCyzBr0Xl9UBsUjizUQGMEY8VK8aGlIbDgs+7jnu0bm
         wqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHv/aL41WzHQ+H0tfq/k2rKmZtvTl6OQfYE5g3fMfiC0vRAuiZ1eujize0l5rXdP5hfAZOpAiD2DvyloL/fJpuT4riHKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygKo6Lb4z9eihYOS0Mxbcf6b2QOox0pmXQSQhzhXvLd78VL0j/
	cQcRXZTJk07ztKB4j2wSzw2JVFUE+9hh/eBctAErU1IFUp6U8Dbt1IvB
X-Gm-Gg: AZuq6aKkTj25aDs5QmuyUbKZwGTM+gOeM7xkNegERrZcnBCMB7op4QHdwrUyTo6EFSH
	IvDBLAQjlETLFyqSunqWbkC7UIGmfYIyuE2nufns1pn41irm06GBqBCZuiWQyO2L5NuCfnwOXns
	AOmmvUx+RRgU3Ex/zoo9d0untn307URp/yOMB+refXpfJB8tnDE3FcS77vRDmzzkc8FhJprTMDd
	+IglkV+4zrRH+ARggEE5TckUqfpYKLgV4Qo1D6o6mvi+G1II0yLiq6bfnVlH+kPUBpBHWcnxFPA
	As7hGuiizZTePk71XiP/ZBXf4y12td/RW9nr300peuw9/LZoT37AQFI7y/3xOjp+1s6rBR0rKsU
	ZmNMbxpuYArj1RIDbrYw0JoLGNE6/DD3Tl7TilNCLNr7/YSK44qiM3ejNJCpdE6an9wAwxvMVM4
	G7QNTowIoNF/AFfHFe7PiKW+RziOip8+Kz1Rum
X-Received: by 2002:a05:600c:3b9d:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-4804c9b0008mr68784385e9.19.1769206297442;
        Fri, 23 Jan 2026 14:11:37 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470474cbsm165841505e9.8.2026.01.23.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 14:11:37 -0800 (PST)
Date: Fri, 23 Jan 2026 23:11:35 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
Message-ID: <20260123.686e220c7b1d@gnoack.org>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
 <6a789aa9-c479-43f9-ac24-bc227f8388c6@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a789aa9-c479-43f9-ac24-bc227f8388c6@maowtm.org>

On Wed, Jan 21, 2026 at 12:26:52AM +0000, Tingmao Wang wrote:
> On 12/30/25 10:39, Günther Noack wrote:
> > The layer masks data structure tracks the requested but unfulfilled
> > access rights during an operations security check.  It stores one bit
> > for each combination of access right and layer index.  If the bit is
> > set, that access right is not granted (yet) in the given layer and we
> > have to traverse the path further upwards to grant it.
> > 
> > Previously, the layer masks were stored as arrays mapping from access
> > right indices to layer_mask_t.  The layer_mask_t value then indicates
> > all layers in which the given access right is still (tentatively)
> > denied.
> > 
> > This patch introduces struct layer_access_masks instead: This struct
> > contains an array with the access_mask_t of each (tentatively) denied
> > access right in that layer.
> > 
> > The hypothesis of this patch is that this simplifies the code enough
> > so that the resulting code will run faster:
> > 
> > * We can use bitwise operations in multiple places where we previously
> >   looped over bits individually with macros.  (Should require less
> >   branch speculation)
> > 
> > * Code is ~160 lines smaller.
> > 
> > Other noteworthy changes:
> > 
> > * Clarify deny_mask_t and the code assembling it.
> >   * Document what that value looks like
> >   * Make writing and reading functions specific to file system rules.
> >     (It only worked for FS rules before as well, but going all the way
> >     simplifies the code logic more.)
> 
> In the original commit message that added this type [1] there was this
> statement:
> 
> > Implementing deny_masks_t with a bitfield instead of a struct enables a
> > generic implementation to store and extract layer levels.
> 
> At some point when looking at this I was wondering why this wasn't a
> struct with 2 u8:4 fields, but rather, a u8 with bit manipulation code.
> While it is possible that I might have just misunderstood it, reading the
> above statement my take-away was that a struct would have forced us to
> address the indices with specific names, e.g. it would need to be defined
> like
> 
> struct deny_masks_t {
>     u8 ioctl:4;
>     u8 truncate:4;
> }
> 
> And it would thus not be possible to manipulate the indices in a generic
> way (e.g. the way it was implemented before, given
> all_existing_optional_access and access_bit, read and write the right
> bits).
> 
> However, since we're now removing that generic-ability, should we consider
> turning it into a struct?  (If later on we have different access types
> that also have optional accesses, we could use a union of structs)

I could not agree more, I also think a struct would be better, and
also rolling it out per access right type is not something I am afraid
of.  I remarked on it in
https://lore.kernel.org/all/20260111.11c57c607174@gnoack.org/

But as Mickaël pointed out in
https://lore.kernel.org/all/20260120.haeCh4li9Vae@digikod.net/, my
endeavors to change the deny masks data type are a bit too intertwined
with the refactoring of transposing the layer masks.  I'll try to
decouple these two changes from each other and send the deny masks
change as a follow-up.


> btw, since this causes conflicts with the quiet flag series and Mickaël
> has indicated that this should be merged first, I will probably have to
> make my series based on top of this.  Will watch this series to see if
> there are more changes.
> 
> Also, this transpose and code simplification should also simplify the
> mutable domains work so thanks for the refactor!

Thanks, I am glad it helps and does not only cause merge conflicts! :)


> A while ago I also made some benchmarking script which I sent a PR to
> landlock-test-tools [2], and earlier I tested this patch with it, and saw
> some improvement (but it was much less in terms of percentage, which may
> be due to the lower directory depth, or may be due to other unknown
> reason):
> 
> TestDescription(landlock=True, dir_depth=10, nb_extra_rules=10)
>   base.2:
>     c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=1718.15, min=1663.00, max=275949.00, median=1696.46, stddev=437.52
>     95% confidence interval: [1718.03 .. 1718.28]
>   Estimated landlock overhead (vs no-landlock): 226.5%
>   48bd90e91fe6.2:
>     c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=1709.60, min=1633.00, max=280608.00, median=1688.83, stddev=441.83
>     95% confidence interval: [1709.48 .. 1709.73]
>     ** Improved 0.5% **
>          ...
>       [1660 .. 1669]:                                             [1660 .. 1669]: ###                                     
>       [1670 .. 1679]: ##                                          [1670 .. 1679]: ###############                         
>       [1680 .. 1689]: ######################                      [1680 .. 1689]: #################################       
>       [1690 .. 1699]: ########################################    [1690 .. 1699]: ##################################      
>       [1700 .. 1709]: ############################                [1700 .. 1709]: #############                           
>       [1710 .. 1719]: #########                                   [1710 .. 1719]: ##                                      
>       [1720 .. 1729]: ##                                          [1720 .. 1729]:                                         
>          ...
>     Estimated landlock overhead (vs no-landlock): 223.0%
> 
> TestDescription(landlock=True, dir_depth=29, nb_extra_rules=10)
>   base.2:
>     c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=3869.66, min=3727.00, max=272563.00, median=3813.42, stddev=666.18
>     95% confidence interval: [3869.47 .. 3869.86]
>   Estimated landlock overhead (vs no-landlock): 427.3%
>   48bd90e91fe6.2:
>     c_measured_syscall_time_ns: 45000000 samples (3 trials), avg=3855.61, min=3697.00, max=271690.00, median=3804.82, stddev=682.74
>     95% confidence interval: [3855.41 .. 3855.81]
>     ** Improved 0.4% **
>          ...
>       [3750 ..   3759]:                                             [3750 ..   3759]: #                                       
>       [3760 ..   3769]:                                             [3760 ..   3769]: #######                                 
>       [3770 ..   3779]:                                             [3770 ..   3779]: ###############                         
>       [3780 ..   3789]: ####                                        [3780 ..   3789]: ###################                     
>       [3790 ..   3799]: ###################                         [3790 ..   3799]: ###################                     
>       [3800 ..   3809]: ######################################      [3800 ..   3809]: ########################                
>       [3810 ..   3819]: ########################################    [3810 ..   3819]: ############################            
>       [3820 ..   3829]: ##########################                  [3820 ..   3829]: #####################                   
>       [3830 ..   3839]: #############                               [3830 ..   3839]: #########                               
>       [3840 ..   3849]: ######                                      [3840 ..   3849]: ##                                      
>       [3850 ..   3859]: ##                                          [3850 ..   3859]:                                         
>       [3860 ..   3869]:                                             [3860 ..   3869]:                                         
>       [3870 ..   3879]:                                             [3870 ..   3879]:                                         
>       ...
>       [4980 ..   4989]:                                             [4980 ..   4989]:                                         
>       [4990 ..   4999]:                                             [4990 ..   4999]:                                         
>       [5000 .. 272563]: #                                           [5000 .. 271690]: #                                       
>     Estimated landlock overhead (vs no-landlock): 424.2%
> 
> Full data including test with 0 depth, or 1000 rules:
> https://fileshare.maowtm.org/landlock-20251230/index.html

Ooh, awesome, thanks for the measurements! :)

The tool I used to benchmark myself [1] is much more crude.  It
purposefully constructs an uncharacteristically bad scenario, to
amplify the performance difference and to make it more measurable.

It creates 10000 nested subdirectories, with a rule for each, so that
landlock_unmask_layers() gets called 10000 times per attempted access
in the innermost directory.

[1] https://lore.kernel.org/all/20251230.d4bf391b98c5@gnoack.org/

–Günther
