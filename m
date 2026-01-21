Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D9738BDA9
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036754; cv=none; b=UhKEaSlO+fM6QReG81i989K2p2OEw+MAnXyFFCbsHlID7Urmi1ZwjdcSn1JacoEuAaz+aEIlItXjIiwNI/a3h2LWzusRj/SWj4O00SqRWQyhfQrM2VdlSXvJkAnPi5femW5o5yL/T10jjcRhgo8PQ9fCC7vDnX3LLYBrXE5Fl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036754; c=relaxed/simple;
	bh=njstbB6X9ioLvfDA0A2yVeTZPl4iMG094RK5wk/54Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJaWIT/jtG8mstKMqNoC1pLcmZHRzIz0WL0CVXTj618Ev0PNU1OzzBLwxtgOm+s1OMA8P2e8y6hQikFuO+AYPfEboUqQXhECyNFUBpacJiA1Yn1F0dpnD0cy0NT7WmDwTJ8UA4Z9AK/PhZJ9Q4bLB6kmZRcd/EtedBHo5pjOWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XJ/tQbZB; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XJ/tQbZB"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dxJjD32L5zlsW;
	Wed, 21 Jan 2026 23:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769034448;
	bh=P58GhBeva6XnfQtE8iTATMoCSyC37vSQH4P+HAPCQas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJ/tQbZBTToZdf+ejbwfuf2Yum6pnckyAwOLCINQqikg4VVjarXr1kmAnpIvriBjA
	 o16Q2E8oaJJLM489kSC9s4e/eyUJHRLuuzLNZQtexV1TTNOISmD/SIjhlqbzvkgImz
	 /OPZPUcdADQQGBdlJ6PigBKYc3c1OrFOzNfh7byM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dxJjC0dp5zSJ3;
	Wed, 21 Jan 2026 23:27:27 +0100 (CET)
Date: Wed, 21 Jan 2026 23:27:25 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
Message-ID: <20260121.ohVah3Ro9rah@digikod.net>
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
X-Infomaniak-Routing: alpha

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

I would prefer to have a more generic implementation, or at least to
make it easy to add this kind of access rights.  Any idea how to improve
the situation?

> 
> 
> btw, since this causes conflicts with the quiet flag series and Mickaël
> has indicated that this should be merged first, I will probably have to
> make my series based on top of this.  Will watch this series to see if
> there are more changes.

I'd like to make sure your quiet flag series is still OK with this
patch, and what would be the impact, so yes, please review and
experiment with this series.

> 
> Also, this transpose and code simplification should also simplify the
> mutable domains work so thanks for the refactor!

Good :)

> 
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

Thanks for the benchmark.

> 
> Full data including test with 0 depth, or 1000 rules:
> https://fileshare.maowtm.org/landlock-20251230/index.html
> 
> 
> [1]: https://lore.kernel.org/all/20250320190717.2287696-15-mic@digikod.net/
> [2]: https://github.com/landlock-lsm/landlock-test-tools/pull/17
> 
