From: bill.c.roberts@gmail.com (William Roberts)
Date: Fri, 20 Oct 2017 18:05:56 -0700
Subject: Can we delete audit_log_secctx()?
In-Reply-To: <1969680b-0239-e6fb-eebd-199467596306@schaufler-ca.com>
References: <1969680b-0239-e6fb-eebd-199467596306@schaufler-ca.com>
Message-ID: <CAFftDdq7ED6w=56mY3rcytMRWqSSN16H56nUW5cq8qdLvJEoEA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Oct 20, 2017 at 3:16 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The function audit_log_secctx() is unused and cannot be
> made safe for the stacked/namespaced security module case.
> It, alas, shows up in the KAPI. Can this derelict code be
> removed? I'll provide a patch it it can go.

It seems to be unused...

http://elixir.free-electrons.com/linux/v4.14-rc5/ident/audit_log_secctx


>
> --
> Linux-audit mailing list
> Linux-audit at redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit



-- 
Respectfully,

William C Roberts
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
