Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7B445ACF;
	Tue, 11 Aug 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456304; cv=none; b=F18yjdmOhTno7pnA84kGBkG8dPLm38hJzwG31hpAZgkVNfvmkopK8Z+ocw55SLLTV3cp11n9JhGxkE08Nipzkxyv6OKXqvBUYbxupiQBTdzGnxbnK/x7zSU13Q3d7/ML/q46kcxIZZFdyWzsqKfcX/H4QaXyCnEL6oBR0k5eyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456304; c=relaxed/simple;
	bh=bIKlTAM6rCJUmXeCTJTWAqsPQhOcFouUMgfFOOeKnak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXDGNlSKGJFfAqof4zdl3cYoR/JkJ+hjwUvc9yQDlxzSYtTR+CsxyagsRJopwHpl1Gf6xklcVZxEqR7cOALC+MILncE5gMp0pxkgEP91/infzdNsdynhJX7PpralDThuoIRuMzAZ3bCAWSx2bnwJGtKQyDDmtcvrsFtjsQjRPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 92181A0442;
	Tue, 11 Aug 2026 13:51:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id B5FE82001B;
	Tue, 11 Aug 2026 13:51:27 +0000 (UTC)
Date: Tue, 11 Aug 2026 09:51:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>, Christian Brauner
 <brauner@kernel.org>, Jann Horn <jannh@google.com>, Jeff Xu
 <jeffxu@google.com>, Justin Suess <utilityemal77@gmail.com>, Kees Cook
 <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet
 <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
 linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Landlock tracepoints
Message-ID: <20260811095139.45267cd6@gandalf.local.home>
In-Reply-To: <20260811094338.288094-1-mic@digikod.net>
References: <20260811094338.288094-1-mic@digikod.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: tkj5u1twemwzxyg3eisdgy66i4z1mzu7
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B5FE82001B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+M14MOg44A/Y/KGagHMgwsOad2zm5ydDE=
X-HE-Tag: 1786456287-190546
X-HE-Meta: U2FsdGVkX19OTjwsYvgWguyDo3JXuXLScjDE3Xu6BbmrK7a4uJi9DNDcPxlN1uTvlAWAyAU2bOSfVqUUz0nOWCJ9UM3yy5o247jv6b6JjJjMMUH2fFVUpHWToYZR+HCvR7z9M4IaZ4fYivi5kiEFpw8lRPyUTmIQT+dyZ4NKpcqk31JK/MYorWZj/nEhXw0nwz6TaTOIz/fY5sSK3XkvTJmJYg2d5tJ7UGq89j5UCHLkUlofkJdtFVvTwfPfH58Qof87KSsl0Khl2EHhl04Ppw7OAZoFB+DL389pRxzF8QZU5iGkSEphphEvUkCZIovqNut+UihQbTKK6wiZ1yEfczi9rvPgg2FO9jC9OoD5BJbmK212w2UOPYc1T4Lr9cP+ZfS1XZuyCOexmKtt29TWXw==

On Tue, 11 Aug 2026 11:43:14 +0200
Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> Steven, Masami, Mathieu, Christian: both helpers are generic and could
> be useful beyond Landlock.  I kept them private only to avoid blocking
> the series on cross-tree review, and I would be happy to move them
> (back) into the tracing core and include/linux/fs.h as shared
> helpers/functions/macros if you prefer, as a follow-up.

Just letting you know. Next week is the merge window and I'll be traveling
then. I'm trying to get everything ready for the merge window this week.

IOW, I'm not going to be able to look at this for at least 2 weeks and by
then I'll forget about it. You can remind me again in 2 or 3 weeks.

Thanks,

-- Steve
