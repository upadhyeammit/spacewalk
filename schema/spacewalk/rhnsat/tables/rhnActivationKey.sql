--
-- Copyright (c) 2008 Red Hat, Inc.
--
-- This software is licensed to you under the GNU General Public License,
-- version 2 (GPLv2). There is NO WARRANTY for this software, express or
-- implied, including the implied warranties of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
-- along with this software; if not, see
-- http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
-- 
-- Red Hat trademarks are not licensed under GPLv2. No permission is
-- granted to use or replicate Red Hat trademarks that are incorporated
-- in this software or its documentation. 
--
--
--
--

create table
rhnActivationKey
(
	token		varchar2(48)
			constraint rhn_act_key_token_nn not null
			constraint rhn_act_key_token_uq unique,
	reg_token_id	number
			constraint rhn_act_key_reg_tid_nn not null
			constraint rhn_act_key_reg_tid_fk
				references rhnRegToken(id)
				on delete cascade,
	ks_session_id	number
			constraint rhn_act_key_ks_sid_fk
				references rhnKickstartSession(id)
				on delete cascade,
	created		date default sysdate
			constraint rhn_act_key_created_nn not null,
	modified	date default sysdate
			constraint rhn_act_key_modified_nn not null
)
	enable row movement
  ;

create index rhn_act_key_kssid_rtid_idx
on rhnActivationKey (ks_session_id, reg_token_id)
        tablespace [[64k_tbs]]
        nologging;

create index rhn_act_key_rtid_idx 
    on rhnActivationKey (reg_token_id)
    tablespace [[64k_tbs]]
    nologging;



create or replace trigger
rhn_act_key_mod_trig
before insert or update on rhnActivationKey
for each row
begin
        :new.modified := sysdate;
end;
/
show errors

--
-- Revision 1.1  2003/10/08 17:25:44  misa
-- bugzilla: 106573  Schema for rhnActivationKey
--
--
