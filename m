Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51374221F04;
	Fri, 18 Jul 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829913; cv=none; b=hI+nr5To7s2XNrMQ1cnF4jLNVgW7uRrNlITTU7KbnKer/u8l5fpg1RI7MksgkIKZwvaBmzqrBk9i1yC0unEQPoOd+hub2b7lBAfzCbb1JrW/iNw+up/yCZFD99ySmn/1H8R6ohjaJ+OfnAxeBLR7jXcaBkERax+O7R2nUhQpBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829913; c=relaxed/simple;
	bh=DqvbrXMz4qPH25izBAOoE+tg01crtThvN9qYeSNBET8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RsehWKBviHz+iy+Abk4UeU3OJhyXxqK7yazHq+5ZYkryrD2l+4DJXKS/4iM1Rf9s1OLFz50UUEZFba5Jj/86XkdTTqlAgGhMlqLYR6SOHWBdQagsEwAFqkw6kR1Cy+fhcLSi0hAjXnjvlfUgaTQICURc/LjS3z1+AjQy/hrryTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=K4dIjt2q; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="K4dIjt2q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9PapmoOxKFgC+jrWSEIuR/hzimXtYSXZjnqcfACEJjg=; b=K4dIjt2qvuHzCc3AAGvu2ksdDU
	nsIMnsBgQggHezz8URH2//dLZLDBFILIGDVEHjLuxOLRCIQedofIwe1m/XB1HkpaqlZ3Q3b/NZgSZ
	HKsYaeWZ8oALtn0GAJUcsdQqAllbKSV1LTa3zPetjmUajWqi1fhQ6/0p1bkva6ctJaFSui0DVTjc4
	1pQ79ZCwjfIvpySj3cp7PM9pqzAnUB1H23tk/yr9etW5n/F5rHQugzecyb7P4O8GZX1Kn414LrsM3
	l7CK5qk65fD807T7OLsmXpUMq8eaKONIEjgYwBn2/8ZI97cSYKGZc4hmeUku76f+jobtNUoDjXlc5
	eUtXQ8/w==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:36235 helo=[10.224.8.110])
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1uch89-0000000AEBa-0dSo;
	Fri, 18 Jul 2025 11:11:49 +0200
Message-ID: <cf43bc15-e42d-4fde-a2b7-4fe832e177a8@oss.cyber.gouv.fr>
Date: Fri, 18 Jul 2025 11:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
References: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
Content-Language: en-US
In-Reply-To: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Note that a hidepid patch has also been sent [1].

[1]: https://lore.kernel.org/all/20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr/

Best regards,

Nicolas

On 7/18/25 10:47, nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Currently, yama only checks if the `PTRACE_MODE_ATTACH` mode is set
> during the `yama_ptrace_access_check()` LSM hook implementation.
>
> In cases of call with the `PTRACE_MODE_READ_FSCREDS` mode, nothing
> happens. Thus, yama does not interact properly with the
> "hidepid=ptraceable" option.
>
> hidepid's "ptraceable" option being documented as follow :
>
> - hidepid=ptraceable or hidepid=4 means that procfs should only contain
>    `/proc/<pid>/` directories that the caller can ptrace.
>
> This patch simply add yama a `PTRACE_MODE_READ_FSCREDS` mode check to
> enable an interaction with "hidepid=ptraceable".
>
> Combined with hidepid=ptraceable, the following behaviors will then
> happen while reading in `/proc/<pid>`:
>
> - "restricted": A process that has a predefined relationship with the
>    inferior will see the inferior process in `/proc`.
>
> - "admin-only": A process that has the CAP_SYS_PTRACE will be able to
>    see every processes in `/proc`.
>
> - "no attach": A process will not see anything but itself in
>    `/proc/<pid>/`.
>
> It is important to note that the combination of "hidepid=ptraceable" and
> yama "no attach" also makes PIDs invisible to root.
>
> No access reports are logged in case of denied access with
> `PTRACE_MODE_READ_FSCREDS` to avoid flooding kernel logs.
>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>   security/yama/yama_lsm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 3d064dd4e03f9eaaf5258b37ad05641b35967995..63b589850a88d35dd6a08b23c14ba1a660e6f1b3 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -352,7 +352,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
>   	int rc = 0;
>   
>   	/* require ptrace target be a child of ptracer on attach */
> -	if (mode & PTRACE_MODE_ATTACH) {
> +	if (mode & (PTRACE_MODE_ATTACH | PTRACE_MODE_READ_FSCREDS)) {
>   		switch (ptrace_scope) {
>   		case YAMA_SCOPE_DISABLED:
>   			/* No additional restrictions. */
> @@ -380,7 +380,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
>   		}
>   	}
>   
> -	if (rc && (mode & PTRACE_MODE_NOAUDIT) == 0)
> +	if (rc && (mode & PTRACE_MODE_NOAUDIT) == 0 && (mode & PTRACE_MODE_ATTACH))
>   		report_access("attach", child, current);
>   
>   	return rc;
>
> ---
> base-commit: 5d8b97c946777118930e1cfb075cab59a139ca7c
> change-id: 20250718-yama_fix-ea5c2c4b2fbe
>
> Best regards,
