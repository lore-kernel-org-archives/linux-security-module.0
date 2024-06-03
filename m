Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9012FF71
	for <linux-security-module@vger.kernel.org>; Mon,  3 Jun 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428151; cv=none; b=LxlMR1VPKTuJlTyb+PO0SFP+xwSV/nDRkuynj0B2406xytPtH9HBPKOmYqDXtD+wCQq2OYz5hhMIPMji0ta2qXLenqPHV+i1aydtS3Nl4ykZLJL+sM9zwF3Lic7xEpPNuJwyugaQPGL553tj6/i23iaWi+VCN9IrJ+Kw4PkMySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428151; c=relaxed/simple;
	bh=/mjcv62h20/YuCxxk+v08bUG5s4jmTFwSRETq+kYZyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNqCA4ON+Sn7ZgD7Q1xuQonY6PEb/g0Vzt9FW39kuRKtMv6h1D2Ra0z4s0B/Sr3bW34wZ3tae5n0nnJyI7SwI4lEXtb1CQO6VYZY8FzTsh+gDk38U2enVl6H197wiOoogXFchzG9uip/scxImrc5D3E5h+yi2dKJvr3EpV1/A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FCviUm6O; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FCviUm6O"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VtHXC0M63zslV;
	Mon,  3 Jun 2024 17:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1717428138;
	bh=f72YWsPTvzhPYR8mlANeq/hcliyb10E3qJT1dzHyWlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCviUm6OSZIQsFmYeFMuIVZSwN3n7uizhrCyJkHYNEMuBhApx6FQ67CDILxyskfop
	 aVAyh5a/QaxyW5HZqgTV0n+wufcPEfHn7T9x3Uhpb8+S66FQgwXnapRugQg/6mMUQc
	 oPo+VOLyV3QwXGr/GGUFWisYCXLdGXACc30gwVBA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VtHX95W5szJ1K;
	Mon,  3 Jun 2024 17:22:17 +0200 (CEST)
Date: Mon, 3 Jun 2024 17:22:12 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: aul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E.Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev, netdev@vger.kernel.org, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Jann Horn <jannh@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v2] landlock: Add abstract unix socket connect
 restrictions
Message-ID: <20240603.Quaes2eich5f@digikod.net>
References: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
 <20240401.ieC2uqua5sha@digikod.net>
 <ZhcRnhVKFUgCleDi@tahera-OptiPlex-5000>
 <20240411.ahgeefeiNg4i@digikod.net>
 <ZlkIAIpWG/l64Pl9@tahera-OptiPlex-5000>
 <20240531.Ahg5aap6caeG@digikod.net>
 <ZlotXL4sfY5Ez3I5@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlotXL4sfY5Ez3I5@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

OK, thanks to your examples I found some issues with this "send/recv"
design.  A sandboxed process should not be able to block actions on
its own socket from a higher privileged domain (or a process without
domain).  One issue is that if a domain D2 denies access (to its
abstract unix sockets) to its parent D1, processes without domains (e.g.
parent of D1) should not be restricted in any way.  Furthermore, it
should not be possible for a process to enforce such restriction if it
is not already sandboxed in a domain.  Implementing such mechanism would
require to add exceptions, which makes this design inconsistent.

Let's get back to the initial "scope" design, which is simpler and
consistent with the ptrace restrictions.  Sorry for the back and forth.
This discussions will be useful for the rationale though. ;)
I kept the relevant parts:

On Fri, May 31, 2024 at 02:04:44PM -0600, Tahera Fahimi wrote:
> On Fri, May 31, 2024 at 11:39:12AM +0200, Mickaël Salaün wrote:
> > On Thu, May 30, 2024 at 05:13:04PM -0600, Tahera Fahimi wrote:
> > > On Tue, Apr 30, 2024 at 05:24:45PM +0200, Mickaël Salaün wrote:
> > > > On Wed, Apr 10, 2024 at 04:24:30PM -0600, Tahera Fahimi wrote:
> > > > > On Tue, Apr 02, 2024 at 11:53:09AM +0200, Mickaël Salaün wrote:

[...]

> > > > > > Because of compatibility reasons, and because Landlock should be
> > > > > > flexible, we need to extend the user space interface.  As explained in
> > > > > > the GitHub issue, we need to add a new "scoped" field to the
> > > > > > landlock_ruleset_attr struct. This field will optionally contain a
> > > > > > LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET flag to specify that this
> > > > > > ruleset will deny any connection from within the sandbox to its parents
> > > > > > (i.e. any parent sandbox or not-sandboxed processes).
> > > > 
> > > > > Thanks for the feedback. Here is what I understood, please correct me if
> > > > > I am wrong. First, I should add another field to the
> > > > > landlock_ruleset_attr (a field like handled_access_net, but for the unix
> > > > > sockets) with a flag LANDLOCK_ACCESS_UNIX_CONNECT (it is a flag like
> > > > > LANDLOCK_ACCESS_NET_CONNECT_TCP but fot the unix sockets connect).

Yes, but the field's name should be "scoped", and it will only accept a
LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET flag.

This is a bit different than handled_access_net because there is no rule
that would accept LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET (i.e. it
is a restriction-only).

Without LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET, the current
behavior should not be changed.  This should be covered with appropriate
tests.

Taking the following examples for domains with
LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET, we get the same
restrictions as with ptrace:

[...]

> /*
>  *        No domain
>  *
>  *   P1-.               P1 -> P2 : allow
>  *       \              P2 -> P1 : allow
>  *        'P2
>  */

This is still correct.

> /*
>  *        Child domain:
>  *
>  *   P1--.              P1 -> P2 : deny
>  *        \             P2 -> P1 : deny
>  *        .'-----.
>  *        |  P2  |
>  *        '------'
>  */

With the "scoped" approach:
P1 -> P2: allow
P2 -> P1: deny

> /*
>  *        Parent domain
>  * .------.
>  * |  P1  --.           P1 -> P2 : allow
>  * '------'  \          P2 -> P1 : allow
>  *            '
>  *            P2
>  */

With the "scoped" approach:
P1 -> P2: deny
P2 -> P1: allow

Indeed, only the domain hierarchy matters, not the process hierarchy.
This works the same way with ptrace restrictions.

> /*
>  *        Parent + child domain(inherited)
>  * .------.
>  * |  P1  ---.          P1 -> P2 : deny
>  * '------'   \         P2 -> P1 : deny
>  *         .---'--.
>  *         |  P2  |
>  *         '------'
>  */

This is still correct.

> /*
>  *         Same domain (sibling)
>  * .-------------.
>  * | P1----.     |      P1 -> P2 : allow
>  * |        \    |      P2 -> P1 : allow
>  * |         '   |
>  * |         P2  |
>  * '-------------'
>  */

This is still correct.

> /*
>  *         Inherited + child domain
>  * .-----------------.
>  * |  P1----.        |  P1 -> P2 : deny
>  * |         \       |  P2 -> P1 : deny
>  * |        .-'----. |
>  * |        |  P2  | |
>  * |        '------' |
>  * '-----------------'
>  */

With the "scoped" approach:
P1 -> P2: allow
P2 -> P1: deny

> /*
>  *         Inherited + parent domain
>  * .-----------------.
>  * |.------.         |  P1 -> P2 : allow
>  * ||  P1  ----.     |  P2 -> P1 : allow
>  * |'------'    \    |
>  * |             '   |
>  * |             P2  |
>  * '-----------------'
>  */

With the "scoped" approach:
P1 -> P2: deny
P2 -> P1: allow

> /*
>  *         Inherited + parent and child domain
>  * .-----------------.
>  * | .------.        |  P1 -> P2 : deny
>  * | |  P1  .        |  P2 -> P1 : deny
>  * | '------'\       |
>  * |          \      |
>  * |        .--'---. |
>  * |        |  P2  | |
>  * |        '------' |
>  * '-----------------'
>  */

This is still correct.
