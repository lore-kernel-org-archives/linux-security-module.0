From: rgb@redhat.com (Richard Guy Briggs)
Date: Tue, 29 Aug 2017 01:06:41 -0400
Subject: [PATCH] lsm_audit: use get_task_comm
In-Reply-To: <CAHC9VhTjpUShdbNpw0SaG0LS44UyLxcbCz+6aPaamA26wA-ywQ@mail.gmail.com>
References: <304ab87b276f87462fbeaccacb9dc1e02300df75.1502451616.git.geliangtang@gmail.com>
	<CAHC9VhTjpUShdbNpw0SaG0LS44UyLxcbCz+6aPaamA26wA-ywQ@mail.gmail.com>
Message-ID: <20170829050641.GW29957@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-08-28 17:54, Paul Moore wrote:
> On Mon, Aug 28, 2017 at 9:58 AM, Geliang Tang <geliangtang@gmail.com> wrote:
> > get_task_comm() copys the task's comm under the task_lock, it's safer
> > than directly using memcpy().
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  security/lsm_audit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 28d4c3a..555b1c4 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -221,7 +221,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> >         BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
> >
> >         audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
> > -       audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
> > +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> >
> >         switch (a->type) {
> >         case LSM_AUDIT_DATA_NONE:
> > @@ -312,7 +312,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> >                                 char comm[sizeof(tsk->comm)];
> >                                 audit_log_format(ab, " opid=%d ocomm=", pid);
> >                                 audit_log_untrustedstring(ab,
> > -                                   memcpy(comm, tsk->comm, sizeof(comm)));
> > +                                   get_task_comm(comm, tsk));
> 
> [NOTE: adding the linux-audit mailing list to this thread]

There was previously pushback about using get_task_comm() with its
locking, which is why in this particular location, a memcpy was chosen
instead.

This was done in:
5deeb5cece3f9b30c8129786726b9d02c412c8ca rgb 2015-04-14
("lsm: copy comm before calling audit_log to avoid race in string printing")

>From that commit:
    Using get_task_comm() to get a copy while acquiring the task_lock to prevent
    this and to prevent the result from being a mixture of old and new values of
    comm would incur potentially unacceptable overhead, considering that the value
    can be influenced by userspace and therefore untrusted anyways.

> This isn't strictly a problem with this patch, but I think we should
> be able to get rid of the 'comm' variable in this if-block as simply
> reuse the 'comm' from the top of the function.  It would be nice to
> include that in this patch.
> 
> Other than that minor nit, this patch looks good to me; if you make
> that small change I'll merge it into the audit/next branch for the
> upcoming merge window.

So, I'd offer a NACK here.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
