import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Row from './TimeslotRow'
import AddTimeslot from './AddTimeslot'

class Event extends Component {
  constructor(props) {
    super(props)

    const {event, users, timeslots} = props

    this.state = {
      showModal: false,
      event,
      users,
      timeslots
    }

    this.toggleModal = this.toggleModal.bind(this)
  }

  toggleModal() {
    this.setState({showModal: !this.state.showModal})
    document.getElementsByTagName('body')[0].classList.toggle('modal-open')
  }

  render() {
    const {event, users, timeslots, authToken } = this.props

    return (
      <div className='event-container'>
        <div className='event__header'>
          <h1>{event.name}</h1>
          <h3>{event.location}</h3>
        </div>
        <table>
          <thead>
            <tr>
              <th />
              {users.sort((a, b) => b.id - a.id)
                    .map(user =>
                      <th key={user.id} className='user'>{user.name}</th>
              )}
            </tr>
          </thead>
          <tbody>
            {timeslots.sort((a, b) => a.start_time - b.start_time)
                      .map(timeslot =>
                        <Row
                          key={timeslot.id}
                          timeslot={timeslot}
                          users={users}
                          duration={event.duration_minutes}
                        />
            )}
          </tbody>
        </table>
        <button
          className='new-timeslot btn'
          onClick={this.toggleModal}
        >
          Add New Timeslot
        </button>

        { this.state.showModal ?
          <AddTimeslot
            eventId={event.id}
            closeModal={this.toggleModal}
            authToken={authToken}
          /> : ''
        }
      </div>
    )
  }
}

Event.propTypes = {
  event: PropTypes.object.isRequired,
  timeslots: PropTypes.array.isRequired,
  users: PropTypes.array.isRequired,
  authToken: PropTypes.string.isRequired
}

export default Event
