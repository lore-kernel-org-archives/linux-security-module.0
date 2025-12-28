Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015E22259A
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766946916; cv=none; b=nd/mgWFILMcJASBOETrxOFJApVUejwwrxVAqt55cCG28MjKMGA6oyxnP4dhKP/EhMgrA9/3VVguI4LADKYgSGgAfIRGja5u0OokEaYtW4KVuLbypuj+PkxGqOgFa4JeiWNNlS91I7hBCu/3yY+5irFQ6JsnIQhc04am6bPIyvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766946916; c=relaxed/simple;
	bh=WvvaXHvS3BzcBfvB0T7a0366331cr/nFFg1mLwxkoNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUmxjZUDINHMXUmPnoDvs+g7j1bW0Be75coOkN+QpsMFm3xaSk17DNgfHB1lQuXE69eU5qrFVOOf1Bwm2DlraTTYWjqiyy6evxbeTU+rBUZVsgNyB02CaNaLlFFvUeWw/zYzZCn3PhiXQqNGyLW+3AKMEDLasrlCiEQPKlKIUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Sib7SW6L; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Sib7SW6L"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dfSHF64cHzdkp;
	Sun, 28 Dec 2025 19:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766945817;
	bh=mqszp1sZ0SLwHznwbKOyQbSP/nOfr0osfraXU0k7YPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sib7SW6LnPaauFDs8CTAcP9SH1eSM5hvKWnKhE2EqyvMo/SD0L82oquBR5Vo0EFSI
	 gBc8HviVPGJixobJY79E8Rko/RQeeGHlQp8peeXwNFqrg6Pk8ddHHLLdhp2F7C+L90
	 lz0tp/FdIDoXgKeexh/fTkCa8vjRD2w55h4NvVMA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dfSHF22VLz32s;
	Sun, 28 Dec 2025 19:16:57 +0100 (CET)
Date: Sun, 28 Dec 2025 19:16:55 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, linux-security-module@vger.kernel.org, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 5/5] landlock: Improve the comment for
 domain_is_scoped
Message-ID: <20251228.Aephei2aecee@digikod.net>
References: <cover.1766885035.git.m@maowtm.org>
 <06393bc18aee5bc278df5ef31c64a05b742ebc10.1766885035.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06393bc18aee5bc278df5ef31c64a05b742ebc10.1766885035.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Dec 28, 2025 at 01:27:35AM +0000, Tingmao Wang wrote:
> Currently it is not obvious what "scoped" mean, and the fact that the
> function returns true when access should be denied is slightly surprising
> and in need of documentation.
> 
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Open to discussion on whether this actually explains it better.
> 
>  security/landlock/task.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index bf4ed15a7f01..6dfcc1860d6e 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -166,15 +166,16 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  }
>  
>  /**
> - * domain_is_scoped - Checks if the client domain is scoped in the same
> - *		      domain as the server.
> + * domain_is_scoped - Check if an interaction from a client/sender to a
> + *    server/receiver should be restricted based on scope controls.
>   *
>   * @client: IPC sender domain.
>   * @server: IPC receiver domain.
>   * @scope: The scope restriction criteria.
>   *
> - * Returns: True if the @client domain is scoped to access the @server,
> - * unless the @server is also scoped in the same domain as @client.
> + * Returns: True if the @server is in a different domain from @client, and
> + *    the @client domain is scoped to access the @server (i.e. access
> + *    should be denied).

I removed the "the" and the heading spaces:

  *
- * Returns: True if the @client domain is scoped to access the @server,
- * unless the @server is also scoped in the same domain as @client.
+ * Returns: True if @server is in a different domain from @client, and @client
+ * is scoped to access @server (i.e. access should be denied).
  */


>   */
>  static bool domain_is_scoped(const struct landlock_ruleset *const client,
>  			     const struct landlock_ruleset *const server,
> -- 
> 2.52.0
> 
