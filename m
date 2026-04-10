Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BC36AB4B
	for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816223; cv=none; b=il6ZI5KsvVN362h0V7W+lzXYXqKWFiR+E0wCwdCFf9sdOWARXuD1976R+D6Mifzghyx3j4w3fnNZampxAUHfRR9uAX4I+pKaDQytK8RfDbw66FBz8rxWfuH6YMEkEnqlgNlHrIV+8R/4EgbcAOExNdfQ7yfM/D61MGg+DGAlfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816223; c=relaxed/simple;
	bh=aoTXi8kCv0n/siDrNA8IooxROchgkFH554sPjIJZg6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QYxTJLp3dI8DgohUALDE6XMBuE1DC54yGGE7Vgy2v4FGWn9ys9HlgznRFRldEA9w1cz1mKKedXpAvetyDLbErYFIDyymIL0kBMRSCnKzcpSyO8DS0JQhCE5ZJyCEjuFzIzVqMwLavZgwMhEONGt2tDGNT1I132Skt4CmAG0+e4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLfZCpjw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLfZCpjw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso1171976f8f.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816220; x=1776421020; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9rShI5mdv2hEKKBqcWX3rqR3B5LhDWxTbl7ZnSCgGk=;
        b=dLfZCpjwDTO99H9ussD/F/FhSyE7PtEeH0zA3azLI53Dd9pTeoT0L6tzmaks8n/tTO
         n+BbgYkDnE4z/Ffl1qZHzZrabO4eoS3SZWFPVgu+/ZRqWPI5Es12YphBEJ+LqX8YSIZ2
         apDAI495VWx1OGwl4AS4MzcnimAJBKjxdBUbV+PAZJvx5ZUY3btEkHB7Jf+RuIxm5zCO
         oKaURcpaTHNSTSZfP/L6tZXRRGXPQnmCeCo5imA7xxopevW+NT3CRBBTukGjJp0F8OR0
         C+8whuxea1n7vHaFZSOu5piZD/9T479koWiEDU9EFk3UY0dPk97Bkb5CKMLSYOjX7Iy+
         BF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816220; x=1776421020;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9rShI5mdv2hEKKBqcWX3rqR3B5LhDWxTbl7ZnSCgGk=;
        b=PXnoqUQlHba/AVoUq39Lg3iV/eZq0YgF4nqv8vd9VM35GcS3Tlle4HmpgPj3M0E7Zf
         mZlcc7B4md+tGDPxedZefmYhTVl8D/8ESaFF6skoIQA9VYoWVed2Xu7+7HOou0MzRjtq
         EJ2PL5sqfSCERHJK/hFoAEdpjTCCFtC6DrIk2JbC+ZFJvlaKqCalBXzLizAxB4dM0Ssd
         SAQXpQPLODcFRL7MzkgAZqe04ta7/rXXYj9pAWv6hpxL7Kfk1fDBk7nHfgQF4WmGdtBW
         /kQFkjsuLRwL3qTLQ84DbKuVm7G9UCmoNYdyJpdVwqG1i5IhL+M2ykSbU1SkeZfGCKmO
         FrCw==
X-Forwarded-Encrypted: i=1; AJvYcCVrggP9aLQ1msJulcgBBPePmN9JOG+OL4drM1+UwUu+Iq2wP0Bsox4VYX/CLNnKzLQcUvHrPqwEbuKBZPJhx6MlwZ21JQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxjgHvY5W6SZdrkR+JxsHEAvvrCWU+j4gbd3OMx3sWl0WD+9m
	9b2wyB07r0zgSLyLFl5KO9CyZVBZapoMc7IohR/xALoD7heiwAgvph1a
X-Gm-Gg: AeBDieuhDlkko1xU69gI68jeaeSXiUkl+s8aGpWxRdvF+v7MsP3uZxkDoOqxusahp5w
	cSAb92kLh8Jl/ScDP41Rb6N7tDlS/cc7Zmbxa8XYtP21wA8mLb2a3MC00e3sahgCrl8f6/b7sUw
	U245Ai1wk+6KqdbGxVkuCdiwDgkUQboMduK0lBdXY1dGyKZN4+aVPHEzV56mYiqgD10CHaX+aaS
	aadyw5J0VfJjqiXQLd7Ag1UjGkRbW3fPbt6C7YC9TnimXGN59eswlCKVNQJ12C7dZnEPNOUKrvJ
	mVQqw8tkuRXX9FyevtWd424zGSz4IkXyvtsgX96iD9P/7f8N0SyaNUmGXD/Hs5IAfj2EJO2qYIW
	6So9+fNNOXkJChVkYc4nuwIBp3d2IOXTFGGFiN14dNV0FlFVU+GMg0Va8dU1F2lIH+w+JctnEmO
	MwEEXD1SZO2Y7wMB8T+Zg=
X-Received: by 2002:a5d:5d83:0:b0:43d:30af:a173 with SMTP id ffacd0b85a97d-43d64259b7emr3549720f8f.5.1775816219806;
        Fri, 10 Apr 2026 03:16:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5062fsm5911153f8f.31.2026.04.10.03.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:16:59 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:16:56 +0300
From: Dan Carpenter <error27@gmail.com>
To: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: [bug report] apparmor: add support loading per permission tagging
Message-ID: <adjOGC9qtr_9XkgS@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello John Johansen,

Commit 3d28e2397af7 ("apparmor: add support loading per permission
tagging") from Apr 1, 2025 (linux-next), leads to the following
Smatch static checker warning:

	security/apparmor/policy_unpack.c:883 unpack_tags()
	warn: missing error code 'error'

security/apparmor/policy_unpack.c
    852 static int unpack_tags(struct aa_ext *e, struct aa_tags_struct *tags,
    853         const char **info)
    854 {
    855         int error = -EPROTO;
    856         void *pos = e->pos;
    857 
    858         AA_BUG(!tags);
    859         /* policy tags are optional */
    860         if (aa_unpack_nameX(e, AA_STRUCT, "tags")) {
    861                 u32 version;
    862 
    863                 if (!aa_unpack_u32(e, &version, "version") || version != 1) {
    864                         *info = "invalid tags version";
    865                         goto fail_reset;
    866                 }
    867                 error = unpack_strs_table(e, "strs", true, &tags->strs);
    868                 if (error) {
    869                         *info = "failed to unpack profile tag.strs";
    870                         goto fail;
    871                 }
    872                 error = unpack_tag_headers(e, tags);
    873                 if (error) {
    874                         *info = "failed to unpack profile tag.headers";
    875                         goto fail;
    876                 }
    877                 error = unpack_tagsets(e, tags);
    878                 if (error) {
    879                         *info = "failed to unpack profile tag.sets";
    880                         goto fail;
    881                 }
    882                 if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
--> 883                         goto fail;

set the error code here

    884 
    885                 if (!verify_tags(tags, info))
    886                         goto fail;

and here

    887         }
    888 
    889         return 0;
    890 
    891 fail:
    892         aa_destroy_tags(tags);
    893 fail_reset:
    894         e->pos = pos;
    895         return error;
    896 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
