Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339FC07E9C
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Jul 2021 20:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38EF613BD
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Jul 2021 20:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhGIUNS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Jul 2021 16:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhGIUNR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Jul 2021 16:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625861429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLMvAaz+yv2TTm+67q7hZDRIjKdaFQ3tWITvUUMiGNA=;
        b=FsOZKb8+OIEw/mA+fBQtRpEjsi6sZesMS3rGcLcGVCT8tvhCQ9GpkSudUUINF1o4o9v8MU
        lRY46wPg7yen5VstIR1XVk+YN6dXESnJYzHVu/67dn+5Z68fSm0TI7ksb+vKUqCo1qj5Ho
        6o3WT2w5drPNnojSc5pyg51h3jqmD/s=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-NxQUTu65O_qKRNXRs--21g-1; Fri, 09 Jul 2021 16:10:28 -0400
X-MC-Unique: NxQUTu65O_qKRNXRs--21g-1
Received: by mail-il1-f198.google.com with SMTP id r19-20020a92c5b30000b02901f175acc987so6629958ilt.21
        for <linux-security-module@vger.kernel.org>; Fri, 09 Jul 2021 13:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLMvAaz+yv2TTm+67q7hZDRIjKdaFQ3tWITvUUMiGNA=;
        b=FKZjvFFpjvd93j4w+bIi9B0p1wQJhbjzSk8DlQmW1cnVo+UtBgDepj2YJqQh0n9S1Q
         vV+nlZcBZXF4FxiKD/df1eNVacoPKE3jsORPeoUhflmaT5JejGNvGvWbQG3LatI31P6D
         liTudFA4hLtWqRrk/O/A3zCTxQrGpFTviZKsZhS4eilJOeZf5Qq6bU2E+uTz4T5LXukA
         b2OaAZfDMIVwt3zZbtGhuF5ky2P53Gq8sVos+3Eo9qkK/nkr1ANC45z1HtdggfblUN+S
         PKAnPU1fM1lMzbW33ePm9fZ2zw56sIaOsPuBnpFca3/D3bxyYrTAONTUle+Cl/mToBqA
         IMSg==
X-Gm-Message-State: AOAM531Uli1AO6gNzRsycbmK0LsG/qNNDDpHaN2CRut6E2naytg1jkpo
        ataiiXGGkNX3rdPYXBIpgwcccmKrf+re08iaH9Jr3DjiQZUiX8f5QIy8GIXDlapvCcJmYAG+oOh
        YkQ8RbNvLN20gGliQXVxKYwVnvbJRoPN0vXJVcQy8cRcl0PjcAOrP
X-Received: by 2002:a5d:840c:: with SMTP id i12mr29354933ion.185.1625861427498;
        Fri, 09 Jul 2021 13:10:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyy48VPgc+w97sRNqo99gp4+TGAhujOUF01iKuIXYqXMDeTCNdeQcQE7P5oy8kE1LUgX1+lWWAHxbriQBBE/0=
X-Received: by 2002:a5d:840c:: with SMTP id i12mr29354915ion.185.1625861427360;
 Fri, 09 Jul 2021 13:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210708175738.360757-1-vgoyal@redhat.com> <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein> <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com> <20210709175947.GB398382@redhat.com>
In-Reply-To: <20210709175947.GB398382@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Fri, 9 Jul 2021 16:10:16 -0400
Message-ID: <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special files
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bfields@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 9, 2021 at 1:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> nfs seems to have some issues.

I'm not sure what the expected behavior is for nfs.  All I have for
now is some generic troubleshooting ideas, sorry:

> - I can set user.foo xattr on symlink and query it back using xattr name.
>
>   getfattr -h -n user.foo foo-link.txt
>
>   But when I try to dump all xattrs on this file, user.foo is being
>   filtered out it looks like. Not sure why.

Logging into the server and seeing what's set there could help confirm
whether it's the client or server that's at fault.  (Or watching the
traffic in wireshark; there are GET/SET/LISTXATTR ops that should be
easy to spot.)

> - I can't set "user.foo" xattr on a device node on nfs and I get
>   "Permission denied". I am assuming nfs server is returning this.

Wireshark should tell you whether it's the server or client doing that.

The RFC is https://datatracker.ietf.org/doc/html/rfc8276, and I don't
see any explicit statement about what the server should do in the case
of symlinks or device nodes, but I do see "Any regular file or
directory may have a set of extended attributes", so that was clearly
the assumption.  Also, NFS4ERR_WRONG_TYPE is listed as a possible
error return for the xattr ops.  But on a quick skim I don't see any
explicit checks in the nfsd code, so I *think* it's just relying on
the vfs for any file type checks.

--b.

