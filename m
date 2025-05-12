Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26014286;
	Mon, 12 May 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088664; cv=none; b=d5qV3Ec7GBUixAuW4YbfhOagV0tPi4jtmG+ZV59N8bInoUP7FsqlaK8rtGmQwPAUTAU5zrwT87U+PW/sVlltHeU94U0OjVXBsxBFrr83dKuDji3bWk0tpJaexkjjAk0Fq/ONcc4SnfLDsNutFb7sthLovrdKgXobDCPqawBbScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088664; c=relaxed/simple;
	bh=arM7eophhT/s+kaTx+ZV+UsjOkaDxf9zdv7JPFMbY1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcYfK0csKzJydB9r+Q2KPgezlD9BqnvBXZCbTWKEQUV1scRkIgzYgcSAS/LHPVdwVMsRG1mpDKfI/R9tfyfpnOkHNPZqgVFfzgjDSNLLMaIVSReRGRC4HqcA7vMvh/2uD48A1SJzvD8NwssrHezxey8l60vWdClZ+hPvxXD3BaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=joEMAjNq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="joEMAjNq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=7FYjVaYHNFCowOsnAQMDafOsP3iqwFtokZlBvgZM5f8=; b=joEMAjNq6gRMolzUoh8gUoDXj6
	aNOg+eoPxT96Tf+r51ye9nRjqiZHh2TgRT0OBpN3MdYBsHeDGdt4nNNx22kGWyRNhiZASAIuqoy21
	ygmC6lBi0mRsyFvLHzzxknL8YhLcQ+gf8uuu03NdOKKqSluTBiYZgRPedwnHAR2MiyaTfQ21eztR+
	ZpAN5NtbtmHb1OwzFs7Do5x1zA/Pj1yHG8mvU8r3h3Hy01YwFHEFmz/ukkY+zuhmeG+E8pA1R21Vq
	ipV0WdrrEGrap2k4WRorVVhiLSHgpYSW9TRmrC+MVWQNsmgmFjdhnVF82hzX+4vlry7R10OF4mFua
	Tq6CP3UQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEbZB-0000000HHSW-2OS1;
	Mon, 12 May 2025 22:24:09 +0000
Date: Mon, 12 May 2025 23:24:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: alexjlzheng@gmail.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in
 securityfs_remove()
Message-ID: <20250512222409.GD2023217@ZenIV>
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
 <20250509032326.GJ2023217@ZenIV>
 <20250509043712.GK2023217@ZenIV>
 <20250509044613.GT2023217@ZenIV>
 <CAHC9VhRp5Nb_1FPu8tF6EUsPpSEbbTT0K7a3V-Z7OWKNXy9Yyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRp5Nb_1FPu8tF6EUsPpSEbbTT0K7a3V-Z7OWKNXy9Yyg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 12, 2025 at 05:19:39PM -0400, Paul Moore wrote:
> On Fri, May 9, 2025 at 12:46 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Fri, May 09, 2025 at 05:37:12AM +0100, Al Viro wrote:
> > > On Fri, May 09, 2025 at 04:23:26AM +0100, Al Viro wrote:
> > >
> > > > I have fixes for some of that crap done on top of tree-in-dcache series;
> > > > give me an hour or two and I'll separate those and rebase to mainline...
> > >
> > > Completely untested:
> > > git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #untested.securityfs
> > >
> > > on top of v6.15-rc5.  And I'm serious about the "untested" part - it builds
> > > with allmodconfig, but that's all I've checked.  So treat that as an outline
> > > of what could be done, but don't use as-is without serious testing.
> >
> > PS: I'm really, really serious - do not use without a serious review; this
> > is a rebase of a branch last touched back in March and it was a part of
> > long tail, with pretty much zero testing even back then.
> >
> > Patches are simple enough to have a chance to be somewhere in the vicinity
> > of being correct, but that's all I can promise.
> 
> Fair enough, although unfortunately I don't think anyone has anything
> close to a securityfs test suite so I suspect this may languish on the
> lists for a bit unless someone has the cycles to pick it up and
> properly test it.
> 
> I haven't compared the patches you posted on-list with the stuff in
> the tree above, but based on the timestamps I'm guessing the on-list
> patches are simply the ones from the tree above?

git format-patch output for that branch...
