From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Apr 2017 14:58:35 -0700
Subject: [PATCH net-next v6 02/11] bpf,landlock: Define an eBPF program
	type for Landlock
In-Reply-To: <20170328234650.19695-3-mic@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
	<20170328234650.19695-3-mic@digikod.net>
Message-ID: <CAGXu5jJQaxTOGgKCcApOiAX+ZnSgGQG6nU30hD0WeyQRcZ=zDg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 28, 2017 at 4:46 PM, Micka?l Sala?n <mic@digikod.net> wrote:
> Add a new type of eBPF program used by Landlock rules.
>
> This new BPF program type will be registered with the Landlock LSM
> initialization.
>
> Add an initial Landlock Kconfig.
>
> Changes since v5:
> * rename file hooks.c to init.c
> * fix spelling
>
> Changes since v4:
> * merge a minimal (not enabled) LSM code and Kconfig in this commit
>
> Changes since v3:
> * split commit
> * revamp the landlock_context:
>   * add arch, syscall_nr and syscall_cmd (ioctl, fcntl?) to be able to
>     cross-check action with the event type
>   * replace args array with dedicated fields to ease the addition of new
>     fields
>
> Signed-off-by: Micka?l Sala?n <mic@digikod.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> ---
> [...]
> +static inline bool bpf_landlock_is_valid_subtype(
> +               union bpf_prog_subtype *prog_subtype)
> +{
> +       if (WARN_ON(!prog_subtype))
> +               return false;
> +
> +       switch (prog_subtype->landlock_rule.event) {
> +       case LANDLOCK_SUBTYPE_EVENT_FS:
> +               break;
> +       case LANDLOCK_SUBTYPE_EVENT_UNSPEC:
> +       default:
> +               return false;
> +       }
> +
> +       if (!prog_subtype->landlock_rule.version ||
> +                       prog_subtype->landlock_rule.version > LANDLOCK_VERSION)
> +               return false;
> +       if (!prog_subtype->landlock_rule.event ||
> +                       prog_subtype->landlock_rule.event > _LANDLOCK_SUBTYPE_EVENT_LAST)
> +               return false;
> +       if (prog_subtype->landlock_rule.ability & ~_LANDLOCK_SUBTYPE_ABILITY_MASK)
> +               return false;
> +       if (prog_subtype->landlock_rule.option & ~_LANDLOCK_SUBTYPE_OPTION_MASK)
> +               return false;
> +
> +       /* check ability flags */
> +       if (prog_subtype->landlock_rule.ability & LANDLOCK_SUBTYPE_ABILITY_WRITE &&
> +                       !capable(CAP_SYS_ADMIN))
> +               return false;
> +       if (prog_subtype->landlock_rule.ability & LANDLOCK_SUBTYPE_ABILITY_DEBUG &&
> +                       !capable(CAP_SYS_ADMIN))
> +               return false;
> +
> +       return true;
> +}

I would add more comments for the rule and ability tests just to help
people read this.

> +
> +static inline const struct bpf_func_proto *bpf_landlock_func_proto(
> +               enum bpf_func_id func_id, union bpf_prog_subtype *prog_subtype)
> +{
> +       bool event_fs = (prog_subtype->landlock_rule.event ==
> +                       LANDLOCK_SUBTYPE_EVENT_FS);
> +       bool ability_write = !!(prog_subtype->landlock_rule.ability &
> +                       LANDLOCK_SUBTYPE_ABILITY_WRITE);
> +       bool ability_debug = !!(prog_subtype->landlock_rule.ability &
> +                       LANDLOCK_SUBTYPE_ABILITY_DEBUG);
> +
> +       switch (func_id) {
> +       case BPF_FUNC_map_lookup_elem:
> +               return &bpf_map_lookup_elem_proto;
> +
> +       /* ability_write */
> +       case BPF_FUNC_map_delete_elem:
> +               if (ability_write)
> +                       return &bpf_map_delete_elem_proto;
> +               return NULL;
> +       case BPF_FUNC_map_update_elem:
> +               if (ability_write)
> +                       return &bpf_map_update_elem_proto;
> +               return NULL;
> +
> +       /* ability_debug */
> +       case BPF_FUNC_get_current_comm:
> +               if (ability_debug)
> +                       return &bpf_get_current_comm_proto;
> +               return NULL;
> +       case BPF_FUNC_get_current_pid_tgid:
> +               if (ability_debug)
> +                       return &bpf_get_current_pid_tgid_proto;
> +               return NULL;
> +       case BPF_FUNC_get_current_uid_gid:
> +               if (ability_debug)
> +                       return &bpf_get_current_uid_gid_proto;
> +               return NULL;
> +       case BPF_FUNC_trace_printk:
> +               if (ability_debug)
> +                       return bpf_get_trace_printk_proto();
> +               return NULL;
> +
> +       default:
> +               return NULL;
> +       }
> +}

I find this switch statement mixed with the "if (ability...)" kind of
hard to read and a bit fragile. I think it'd be better written as:

switch (func_id) {
case BPF_FUNC_map_lookup_elem:
   return ...
}

if (ability_write) {
    switch (func_id) {
        ...
    }
}

if (ability_debug) {
    switch (func_id) {
        ...
    }
}

return NULL;

Then it's self-documenting and it's harder to add a case without the
desired ability check...

> +static const struct bpf_verifier_ops bpf_landlock_ops = {
> +       .get_func_proto = bpf_landlock_func_proto,
> +       .is_valid_access = bpf_landlock_is_valid_access,
> +       .is_valid_subtype = bpf_landlock_is_valid_subtype,
> +};
> +
> +static struct bpf_prog_type_list bpf_landlock_type __ro_after_init = {
> +       .ops = &bpf_landlock_ops,
> +       .type = BPF_PROG_TYPE_LANDLOCK,
> +};

Yay const and ro_after_init! :)

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
