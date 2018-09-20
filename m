From: fw@strlen.de (Florian Westphal)
Date: Thu, 20 Sep 2018 11:44:58 +0200
Subject: [PATCH] netfilter: nf_tables: add SECMARK support
In-Reply-To: <CAJ2a_DfGCRXaH9BkBj=0R1Cr3jiHQHgq-pU2HGuWudvWCSKLQg@mail.gmail.com>
References: <20180919231402.4482-1-cgzones@googlemail.com>
	<75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
	<20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
	<CAJ2a_DfGCRXaH9BkBj=0R1Cr3jiHQHgq-pU2HGuWudvWCSKLQg@mail.gmail.com>
Message-ID: <20180920094458.6hwaw3vgfsxvcgb4@breakpoint.cc>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Christian G?ttsche <cgzones@googlemail.com> wrote:
> > Fixes should go into nf.git whereas feature goes to nf-next.git.
> 
> No, that should not be a unroll fix.
> Currently there are no objects registered by the main nf_tables
> module, so for nft_secmark_obj_type I had to introduce this new logic.

I see, ok.

> > > > +   if (err) {
> > > > +           if (err == -EINVAL)
> > > > +                   pr_notice_ratelimited("invalid security context \'%s\'\n", priv->ctx);
> > > > +           else
> > > > +                   pr_notice_ratelimited("unable to convert security context \'%s\': %d\n", priv->ctx, -err);
> > > > +           return;
> > > > +   }
> >
> > Please remove these printks(), they do not really help as user can't
> > take any action anyway.
> 
> Aren't they helpful?
> "invalid security context" can pop up if someone supplies an invalid
> SELinux context (nft add secmark inet filter sshtag
> \"this_is_invalid\") and uses it

Can't that be caught at ->init() time?
We can then reject this via plain -EINVAL.

No need for printk because caller knows which expression/object caused
the error.

> "unable to convert security context" can pop up if no LSM is enabled

Can that be done at ->init() time when we can still reject the (invalid)
rule?

> "unable to map security context" should never happen, but one never knows

Ok, but what is user supposed to do?
This just causes perpetual spew of warnings in the kernel ring buffer.

> "unable to obtain relabeling permission" can pop up if e.g. the
> SELinux permission "kernel_t ssh_server_packet:packet relabelto" is
> missing

Makes sense, but this will need to be a plain
return -EPERM, this function can only be used in process context.
