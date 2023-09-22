Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD36CD4850
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Sep 2023 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjIVSmg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjIVSmg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 14:42:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B9DA9;
        Fri, 22 Sep 2023 11:42:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-532c66a105bso3054534a12.3;
        Fri, 22 Sep 2023 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695408148; x=1696012948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A07py4MTlmtIRoHDL+wrJZuQS+RAbNl3SUABDDToi9g=;
        b=lbI5k+/gyR4nsvGKGxtc7PY4jdOLk0VIA7k/HjMup0Rd6CbZfMjMZsrIhYZvPT7l7P
         e/CKbcN9vPweVOEi7u3zWBKKTl1AcMv85o2epKEWNXibWv/5e89TICUsmLaYyQXslYvt
         lP/7DQKHg+wByXmyBvVVqsI7a5NEbDFMUeNF6Ss0WEi1/G50N73XF9wyJv4Q8iTxFfcp
         /MqafQvQ/WVRR634CrgYK4/3FbUDz/R9VYdKbrAyBL72zXnem/wXOiaeZ1VirH+qtwXo
         FtvFASfoJBiAROUCSFEMtnQQjxqca/e0eL5N/F5EEBpqTHTDUmM/alD8iD3u39TbuDsk
         vALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408148; x=1696012948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A07py4MTlmtIRoHDL+wrJZuQS+RAbNl3SUABDDToi9g=;
        b=ShPBoIm3I/fUdog0C7bo2bULhdTa3CCUg0ULPsKhNXyrDOsUgvmgaou3o959bLRgqH
         RMd0VDBs0HctLamfPQG7W6BEu9Fk8uGLYx+OAvFuiy2lE7ZNd+TtX37cw4cjOnkLZsWW
         6CPdn+QuWo8psLMDIv5oV88wWLYzrTaAcdhjkUlwagK16a/HtBLB3ueFyh5VSwqlXzMw
         BMC+DbqLE7gPWSMdnBiLVmAqkz6Bt0kLoj54/eZQVh9cUUwg4mbIbVBwWL7UBRhiu6Oh
         ag2TeQvRkEH+qRSgowuJ+QnUc+vG0wTsvbF/sOSKpZQkRJ/oMt+hvoWSoDacHPhV753A
         jy8w==
X-Gm-Message-State: AOJu0Yze1q3vpsLVmKizfGfZio6zZ2m3xABqN0PWfdoH7F+FTBMxFpAF
        XVxDUYwFWTy+iet5bCyP9Ms=
X-Google-Smtp-Source: AGHT+IGAXpsGQGhQAXFNELhiI7tG9YTVnUt0vp01z0qFoa9vgsCbFmzQ0pGhjEszK3XUaBkCBTSscg==
X-Received: by 2002:a17:906:28d:b0:9b0:169b:eece with SMTP id 13-20020a170906028d00b009b0169beecemr213729ejf.40.1695408148133;
        Fri, 22 Sep 2023 11:42:28 -0700 (PDT)
Received: from f (cst-prg-31-165.cust.vodafone.cz. [46.135.31.165])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b009a1be9c29d7sm3079107ejb.179.2023.09.22.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:42:27 -0700 (PDT)
Date:   Fri, 22 Sep 2023 20:42:24 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
Message-ID: <20230922184224.kx4jiejmtnvfrxrq@f>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-1-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
> Since we know the address of the enabled LSM callbacks at compile time and only
> the order is determined at boot time, the LSM framework can allocate static
> calls for each of the possible LSM callbacks and these calls can be updated once
> the order is determined at boot.
> 

Any plans to further depessimize the state by not calling into these
modules if not configured?

For example Debian has a milipede:
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

Everything is enabled (but not configured).

In particular tomoyo is quite nasty, rolling with big memsets only to
find it is not even enabled.
