Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47F1D514E;
	Mon, 10 Mar 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643576; cv=none; b=Qk9YkX18wmbL4iVhQb83xb8F/Gvz9LgmPkp5KcC57Y5kY/YVMci7RDLTzcqS3d+3TO5eXAf11iKpCelNz3dpoYJ4tXDXiMMvHoLN4rFowgP1Zsv/oD7yx5lyXf4OAJBipReUWVewMBZwbyDvqO5pLcRMQ8MJmoaGdvzqV2hfz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643576; c=relaxed/simple;
	bh=ROze6vC3id3Mcda8UXwEms4XP4BB8UY5Qt173HNZGwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK6XtElHt2PWQI60xHzIqli4NroFmyySulI7aoWS1PAshnhxJkqB/qUdR3hfKvNKm68iJsczBwV7VaKMJgSoYRNXVLMFVvY/iH25udhKi64yq7XU2N8DQA31NT71F6jo0iVsF0Z3VwuCNzvQ27m3BHbgbrBWhLUXlbmMibEmrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D9AB214DC; Mon, 10 Mar 2025 16:52:51 -0500 (CDT)
Date: Mon, 10 Mar 2025 16:52:51 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, sergeh@kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Serge Hallyn as maintainer for creds
Message-ID: <20250310215251.GA196422@mail.hallyn.com>
References: <Z82Sug-XLC1r5wKE@lei>
 <f44bad6065bbf45c02dc7caf90ed0e7e@paul-moore.com>
 <20250310213237.GA195898@mail.hallyn.com>
 <CAHC9VhTSdq=zrkmipZJjTMcudbyvHJeq+XR3Td7mr7cEn+GDEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTSdq=zrkmipZJjTMcudbyvHJeq+XR3Td7mr7cEn+GDEA@mail.gmail.com>

On Mon, Mar 10, 2025 at 05:36:54PM -0400, Paul Moore wrote:
> On Mon, Mar 10, 2025 at 5:32 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Mon, Mar 10, 2025 at 03:58:41PM -0400, Paul Moore wrote:
> > > On Mar  9, 2025 sergeh@kernel.org wrote:
> > > >
> > > > Also add the documentation file as suggested by Günther Noack.
> > > >
> > > > Signed-off-by: Serge Hallyn <sergeh@kernel.org>
> > > > ---
> > > >  MAINTAINERS | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > I adjusted the subject line to reflect that you chose the reviewer role,
> > > but otherwise this looks good, merged into lsm/dev.  Thanks!
> >
> > Oh, did I?  I went back and forth, and actually *intended* M, but must
> > have left my git index out of sorts :)  No problem - reviewer probably
> > makes more sense.
> 
> The patch you posted to the mailing list had "R:" before your name :)
> 
> I'm happy either way, if you would prefer a "M:" just let me know and
> I can update the commit.

R is fine - thanks.
