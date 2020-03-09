Return-Path: <SRS0=zxnP=42=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09090C10F25
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Mar 2020 22:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EA72253D
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Mar 2020 22:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR21PSz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCIWth (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:49:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727322AbgCIWtg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Mar 2020 18:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583794175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HV3qgkcKTLqlj5wcbDRS2AXp9vzUwXBC/9+EqfzmMvM=;
        b=HR21PSz2YUlAgq9+xbzW4xwXnvcwDMe/xXZ6fqabR1O3aLrgT2p1Vf3lWR+xgbkeqrHNw0
        93zUl90kxIKimP/fUDunwcL3ajGLEEVMJXXYXb457Xs+B2IxA9WIHkjcaJtORYQd7pebls
        W1UTKAwDyNq/myibhxlHg5U6H3La+bI=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-zI6IBJ-xN4mymVf47L8rEQ-1; Mon, 09 Mar 2020 18:49:34 -0400
X-MC-Unique: zI6IBJ-xN4mymVf47L8rEQ-1
Received: by mail-yw1-f70.google.com with SMTP id u140so17980558ywf.13
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2020 15:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HV3qgkcKTLqlj5wcbDRS2AXp9vzUwXBC/9+EqfzmMvM=;
        b=eDX1lIKLpQChN+Eioq6LWCYToza3arF7KyEwDmEJgjjFD54+z/C0hXrEximefmwsqZ
         woBL3MK5GRBvwoel7+WBlt9SZC+J0i+ENTFdYwRANaQVHT1LbibqHwM/S/VftkFXh8dE
         k4+WB90wnax/4MV7Ij8VyxG4boeFGdXxExudVVIyCZtApYqIjUDBCiBSNcIaNpYT3ouh
         li/1hZ0n/Yrf3URF8taPFmceFa1EKBc1tMfN0FOnfh7Hh/8xYa4DsYtEi8jmcAXp1d+s
         mpjklsKxjDZkvJyjOfpAFSMK9opB/Js5Iv3lWZt3YgdYPEO+iIgWAItK2qQLAIlZKItX
         pByw==
X-Gm-Message-State: ANhLgQ3lpjK6gLxLPDGYBpNhIZXxtFpgIfwRB2UXoKmFD2eyrW868yAn
        7oDy+tYs6xfYXZvstFWDTW8Aj2YN5Z3Uo+qkmOgzsGpzxhG8Z6a/i53eym+3pbbmHFnceqy8uFw
        sLSxDXe7qZJbZz0Y/tEyGjWf/ENyMoblL4uEL
X-Received: by 2002:a25:2146:: with SMTP id h67mr19645189ybh.92.1583794173503;
        Mon, 09 Mar 2020 15:49:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvt6Q0tj/V6bzMSoorE++/YZCJuiryDKikREWseTxP4/vg08CzbzDn75K5ktPnB52gDWscllg==
X-Received: by 2002:a25:2146:: with SMTP id h67mr19645165ybh.92.1583794173070;
        Mon, 09 Mar 2020 15:49:33 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id w17sm3584845ywa.8.2020.03.09.15.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:49:32 -0700 (PDT)
Message-ID: <32c384ac3adf0cf924d3071a13af7edffe53cc2b.camel@redhat.com>
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
From:   Jeff Layton <jlayton@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Theodore Ts'o <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 18:49:31 -0400
In-Reply-To: <20200309192240.nqf5bxylptw7mdm3@alap3.anarazel.de>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
         <2d31e2658e5f6651dc7d9908c4c12b6ba461fc88.camel@redhat.com>
         <20200309192240.nqf5bxylptw7mdm3@alap3.anarazel.de>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2020-03-09 at 12:22 -0700, Andres Freund wrote:
> Hi,
> 
> On 2020-03-09 13:50:59 -0400, Jeff Layton wrote:
> > The PostgreSQL devs asked a while back for some way to tell whether
> > there have been any writeback errors on a superblock w/o having to do
> > any sort of flush -- just "have there been any so far".
> 
> Indeed.
> 
> 
> > I sent a patch a few weeks ago to make syncfs() return errors when there
> > have been writeback errors on the superblock. It's not merged yet, but
> > once we have something like that in place, we could expose info from the
> > errseq_t to userland using this interface.
> 
> I'm still a bit worried about the details of errseq_t being exposed to
> userland. Partially because it seems to restrict further evolution of
> errseq_t, and partially because it will likely up with userland trying
> to understand it (it's e.g. just too attractive to report a count of
> errors etc).

Trying to interpret the counter field won't really tell you anything.
The counter is not incremented unless someone has queried the value
since it was last checked. A single increment could represent a single
writeback error or 10000 identical ones.

There _is_ a flag that tells you whether someone has queried it, but
that gets masked off before copying the cookie to userland.

> Is there a reason to not instead report a 64bit counter instead of the
> cookie? In contrast to the struct file case we'd only have the space
> overhead once per superblock, rather than once per #files * #fd. And it
> seems that the maintenance of that counter could be done without
> widespread changes, e.g. instead/in addition to your change:
> 

What problem would moving to a 64-bit counter solve? I get the concern
about people trying to get a counter out of the cookie field, but giving
people an explicit 64-bit counter seems even more open to
misinterpretation.

All that said, is an opaque cookie still something you'd find useful?

> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index ccb14b6a16b5..897439475315 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -51,7 +51,10 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
> >  		return;
> > 
> >  	/* Record in wb_err for checkers using errseq_t based tracking */
> > -	filemap_set_wb_err(mapping, error);
> > +	__filemap_set_wb_err(mapping, error);
> > +
> > +	/* Record it in superblock */
> > +	errseq_set(&mapping->host->i_sb->s_wb_err, error);
> > 
> >  	/* Record it in flags for now, for legacy callers */
> >  	if (error == -ENOSPC)
> 
> Btw, seems like mapping_set_error() should have a non-inline cold path?

Good point. I'll do that in the next iteration.

-- 
Jeff Layton <jlayton@redhat.com>

