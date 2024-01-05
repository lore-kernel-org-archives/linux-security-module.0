Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448753175C;
	Fri,  5 Jan 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAy6+IeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C24C433C8;
	Fri,  5 Jan 2024 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704470562;
	bh=BdEJRBnD80tANcDQefdrJ/s2N4HzXSkvbigcwSBiBKg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iAy6+IeLThkJwLyZHHNs88zPMTckABq2hifD8khVykX80K6XyPT13D/QgxlfdRn6M
	 zzwQeR+x9T9Hr4yzLYVDJcMHXdqmzWNGCILpKcP5x/qRqI8DKTEYW33PSh/K+nAQzB
	 lNagiAmHsPhJKUNj5L7BKQ0kfV3P0HS/PA8JkDLAIe+ScWv+x/tpWfzKZTj2hSDCga
	 aFRREN0R3IKEF7dBxGppBTUT18io7YS33AE7x0u0nCxFKfQ0kghpBF7LYXHt2xUFPQ
	 wdwRAyBsM/2rKnnstJE8wi3LHzptDIq4+EDfkcUzq//jkrB/IRbv8YE5IFh7Us/h4Q
	 DmcTFt9u8UuFw==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jan 2024 18:02:38 +0200
Message-Id: <CY6WDWW69XDP.2E8GFRMXYTB22@suppilovahvero>
Cc: <linux-integrity@vger.kernel.org>, <itrymybest80@protonmail.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Dmitry Kasatkin"
 <dmitry.kasatkin@gmail.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] integrity: don't throw an error immediately when failed
 to add a cert to the .machine keyring
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Coiby Xu" <coxu@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231227044156.166009-1-coxu@redhat.com>
 <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>
 <43dozoqfip7m6nglbwzwyzykx23fpzbp7d42pcqzudnzlfvfkb@yjvuo5a6suvv>
In-Reply-To: <43dozoqfip7m6nglbwzwyzykx23fpzbp7d42pcqzudnzlfvfkb@yjvuo5a6suvv>

On Fri Jan 5, 2024 at 3:20 PM EET, Coiby Xu wrote:
> On Wed, Jan 03, 2024 at 04:09:29PM +0200, Jarkko Sakkinen wrote:
> >On Wed Dec 27, 2023 at 6:41 AM EET, Coiby Xu wrote:
> >> Currently when the kernel fails to add a cert to the .machine keyring,
> >> it will throw an error immediately in the function integrity_add_key.
> >>
> >> Since the kernel will try adding to the .platform keyring next or thro=
w
> >> an error (in the caller of integrity_add_key i.e. add_to_machine_keyri=
ng),
> >> so there is no need to throw an error immediately in integrity_add_key=
.
> >>
> >> Reported-by: itrymybest80@protonmail.com
> >
> >Missing "Firstname Lastname".
>
> Thanks for raising this concern! I've asked the reporter if he/she can
> share his/her name.

Also, it is lacking fixes tag.

Fixes tag is mandatory, name part would be super nice to have :-) Since
this categories as a bug fix, getting them in is 1st priority and that
thus does not absolutely block applying the change. Thanks for going
trouble trying to query it, however.

BR, Jarkko
