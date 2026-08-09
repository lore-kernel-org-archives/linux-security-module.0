Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37825A321
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290809; cv=none; b=pGWsCFM5mNwwIEYUtT8O250lEdP4f4qvHynvCUd6iS+341WbDYf876DJlqEHMZC9Z6B9i7Ajsi5TvhLYsWOpmFYzSsIU/tfaOO3pUv2XMTC5UcPoPpecBGLrmmxf1NuCHtpjOIvxiESZtFAKtkfTwl/1ado/s8K6t/mnGkjFeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290809; c=relaxed/simple;
	bh=lpJX2VvQWds7UaHqHKcqf3BhmVv6eto0XUKo9Ygdsp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz6MUzqlVQ5Bf088irf0bjXL5CI1+7tHhfCIvzxE+UUy8hKbhgMSbUQc7UyCB9ULIUIe2cpoHBg8Wm0TNYGabUN++gz25ZtS+g+qIA1wKQ1J62KouPm8eP9OUREXnVuwuPw7EqqovRyveFaa9UFSZTb2iAz3Rs/jnYYjm6njmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7S5D6Hc; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7S5D6Hc"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664db84f074so1354617d50.0
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786290807; x=1786895607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S31dL65i3e1+Hl7HbOOOj3oDI7h8+o5Mt6vOzWfglv8=;
        b=V7S5D6HcDiJdlLO7VJplPv8BCRrlg+bc/N8icRca2m1VCX2O8MIWqCWxv9lK/o6jBR
         /W97tEJxggIbhMDscfzyWCqFG6gBfdo+NanifMSuNPcpo4aZ3wyRE4hksDWEBPabWU/r
         biRtDpUVzUh4jNxgCSTVXZ9HCf7wYhlp02LJJEAqDTmlHMF1I/MLMI0rqVx3HQFGuDrH
         Uz0e9ZvTULnLkBD0R+oMt/ngIkGOgZrnF4fqYF0//nE44tBAwKmOkVhMD7bkj9LORBmd
         D0Du0KSQF7yw6rbugydH17B/LCdiW9dTahRJHnxv02uR+tiKCip5ld4ARgVS/lte0eZH
         zZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786290807; x=1786895607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S31dL65i3e1+Hl7HbOOOj3oDI7h8+o5Mt6vOzWfglv8=;
        b=MvFI/1KR1y8SczCXyOnxENHPoL4eXA+vqucoCWj0+hEjMywdO/OZYWP48mzarOr4DM
         ocix3bkG5zgwhUEZzhU/0GCQPu374lzwfLQI9XM0NvegsHvt+eOdHujfCnckYSFr4/Jy
         XYlgxCYlykNW62rf229o6q9Rok93wvgghc6yvGdLKiLgoL6tnHraJwEPX/D1SLAdN26+
         tHVb5fa3lgqx5BsoJ8cPALNWT/GYHKvhpY6mCV7S7XU508yJY3BmuOFc/4P+n87B7oz0
         OAeOguAdSvnAmq7TtSRh+50LVW+KEC3Y5nEjTDcWVmrqZm9ePpieUhBJyLxNLoDscc65
         Dh2A==
X-Forwarded-Encrypted: i=1; AHgh+Rq9dKkaIvbleVVa6+YdGHRx8gWLIMFXMEKT/kHBD6IJpVxy7jEVHwLscfF2k849qZSu352qTV+yopXbt2NrJfBelAR4Q20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxAXi9ArAMwOdXNkLFmbZtw+f4Ok/Ncd0dXw1kbeeQ0jtMOHm
	pHUMCmKR+5IXbnIRS2v12EjIhAxJeyblIIoZLVP8DfWsxzLMV8UGd5IG3fIl3+9h
X-Gm-Gg: AR+sD10XP+vPhLhSWyAgaJtk9Fk69DUCThnzr4lsxtFcoSDsRIeVA+SwPuRU9xsHz+Y
	nH/YiNT2D5rnxYAjGVK+fLsHpdJ2pb/tbFT+06Zluk0mPD+m3rDigoP9ueWehAK8UAH/JaJk/5E
	YKz/W3o6b4CAtbRgbPYrmghE/7Y83F6mtuI2/NO2HQmR8WrPsMR8yrkgooMAIbNYuuVuQelX3mP
	I4ft0MWboBFGJg0yQ0deGNi7wBSH9ngWxU3NXbLhiolJNgLanlB5Ah08RJ4gicgFcoyjOApxGzs
	f0bPr7jkaauh3oKA+C5dSAn274JBYB3rpvyTQpqiakUHOKDKLKBpnP3u+FwDK+xqmRpmXxwQSN4
	wgb9gntmC0gMXfq6XHIeWFuU7UmppepaUPwUZeu1OTGfGuY440hGzVjXmbXHOtrNdjsuOrNXu7Z
	FQdxdrsAHGKdXt90eH++rcDbbcBdXi+WuX1HZzQcAi17dUx26rEziaCsA+aYZ/lEnUZMmaGEgg0
	/0/AkkQMe0hMdJGKVh7xFg=
X-Received: by 2002:a05:690c:6209:b0:81e:7d90:5673 with SMTP id 00721157ae682-820224ace00mr223556707b3.26.1786290806951;
        Sun, 09 Aug 2026 08:53:26 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f577ddf8sm41741927b3.30.2026.08.09.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:53:26 -0700 (PDT)
Date: Sun, 9 Aug 2026 11:53:25 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <anih6rJdlAuSaW-Q@zenbox>
References: <20260809154544.1253100-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809154544.1253100-1-utilityemal77@gmail.com>

On Sun, Aug 09, 2026 at 11:45:18AM -0400, Justin Suess wrote:
> Howdy
> 
> This series adds a new landlock_restrict_self(2) flag:
> LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.
>
gmail for some reason in their infinite wisdom decided to drop my second
patch 2/5 (the core patch of this series) for seemengly no reason. At
least they sent me a bounce email...

Anyways I'll RESEND the series later and hope I don't get bounced again...

Justin
> The flag sets the no_new_privs attribute of the calling thread only
> once the enforcement of the ruleset succeeded: no_new_privs is set if
> and only if the landlock_restrict_self(2) call succeeds.
> 
